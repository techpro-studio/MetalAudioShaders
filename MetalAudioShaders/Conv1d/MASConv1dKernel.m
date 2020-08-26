//
//  MPSConv1DKernel.m
//  audio_test
//
//  Created by Alex on 05.08.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

#import "MASConv1dKernel.h"
#import "half.h"
#import "MASCommandEncoderExtension.h"


@implementation MASConv1dKernel
{
    MASConv1dDescriptor *descriptor;
    id<MTLBuffer> weights;
    id<MTLBuffer> biases;
}

- (instancetype)initWithDevice: (id<MTLDevice>) device
                 andDescriptor: (MASConv1dDescriptor *) descriptor
                       weights: (MASShapedBuffer *) weights
                        biases: (MASShapedBuffer *) biases;
{
    self = [super initWithDevice:device functionName: descriptor.useSinglePrecision
            ? @"conv1d_float" : @"conv1d_half"];
    if (self) {
        NSUInteger weightsCount = descriptor.inputFeatureChannels * descriptor.outputFeatureChannels * descriptor.kernelSize;
        self -> descriptor = descriptor;
        self -> weights = [self makeMTLBuffer: weightsCount fromShaped:weights];
        self -> biases = [self makeMTLBuffer: descriptor.outputFeatureChannels fromShaped:biases];
    }
    return self;
}

-(id<MTLBuffer>) makeMTLBuffer: (NSUInteger) count fromShaped:(MASShapedBuffer*) shapedBuffer
{
    NSUInteger size = (descriptor.useSinglePrecision ? sizeof(float) : sizeof(half)) * count;
    id<MTLBuffer> buffer = [self.device newBufferWithLength: size  options: MTLResourceStorageModeShared];
    memcpy([buffer contents], [shapedBuffer buffer], size);
    return  buffer;
}

-(void) encodeToCommandBuffer: (id<MTLCommandBuffer>) buffer
                  inputMatrix: (MPSMatrix * _Nonnull) inputMatrix
                 resultMatrix: (MPSMatrix * _Nonnull) resultMatrix
{
    __auto_type commandEncoder = [buffer computeCommandEncoder];
    if (commandEncoder == nil){
        NSLog(@"Empty command encoder");
        return;
    }

    unsigned short config[6] = {
        descriptor.kernelSize,
        descriptor.inputFeatureChannels,
        descriptor.outputFeatureChannels,
        descriptor.stride,
        descriptor.inputSize,
        descriptor.outputSize
    };

    [commandEncoder setComputePipelineState: self.pipelineState];
    [commandEncoder setBytes: &config length: 6 * sizeof(unsigned short) atIndex: 0];
    [commandEncoder setBuffer: inputMatrix.data offset: 0 atIndex: 1];
    [commandEncoder setBuffer: resultMatrix.data offset: 0 atIndex: 2];
    [commandEncoder setBuffer: weights offset: 0  atIndex: 3];
    [commandEncoder setBuffer: biases offset: 0 atIndex: 4];

    [MASCommandEncoderExtension dispatchMatrix: resultMatrix inCommandEncoder: commandEncoder with:self.pipelineState];

    [commandEncoder endEncoding];
}

- (void)describe
{
    NSLog(@"Conv1D Kernel size(%d) : Input(size: %d, features: %d) -> Output(size: %d, feautures: %d)", descriptor.kernelSize, descriptor.inputSize, descriptor.inputFeatureChannels, descriptor.outputSize, descriptor.outputFeatureChannels);
}

@end
