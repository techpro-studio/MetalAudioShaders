//
//  SpectrogramKernel.m
//  audio_test
//
//  Created by Alex on 09.08.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

#import "SpectrogramKernel.h"
#import "CommandEncoderExtension.h"
#import <Accelerate/Accelerate.h>


typedef struct {
    unsigned short outputFeatureChannels;
    unsigned short outputSize;
    unsigned short nfft;
    unsigned short step;
    float normalizationFactor;
} Config;

@implementation SpectrogramKernel
{
    SpectrogramDescriptor *descriptor;
}

- (instancetype)initWithDevice:(id<MTLDevice>)device
                 andDescriptor:(SpectrogramDescriptor *)descriptor
{
    NSString* functionName = [NSString stringWithFormat:@"spectrogram_%@_%@", descriptor.isComplex ? @"complex" : @"real", descriptor.useSinglePrecision ? @"float" : @"half"];
    self = [super initWithDevice:device functionName: functionName];
    if (self) {
        self -> descriptor = descriptor;
    }
    return self;
}

-(void) encodeToCommandBuffer: (id<MTLCommandBuffer>) buffer
                  inputVector: (MPSVector * _Nonnull) inputVector
                 resultMatrix: (MPSMatrix * _Nonnull) resultMatrix
{
    __auto_type commandEncoder = [buffer computeCommandEncoder];
    if (commandEncoder == nil){
        NSLog(@"Empty command encoder");
        return;
    }


    Config config = {
        descriptor.outputFeatureChannels,
        descriptor.outputSize,
        descriptor.nfft,
        descriptor.step,
        descriptor.fftNormalizationFactor
    };

    [commandEncoder setComputePipelineState: self.pipelineState];
    [commandEncoder setBytes: &config length:sizeof(Config) atIndex: 0];
    [commandEncoder setBytes: descriptor.window.buffer length: descriptor.window.bufferLength atIndex:1];
    [commandEncoder setBuffer: inputVector.data offset: 0 atIndex: 2];
    [commandEncoder setBuffer: resultMatrix.data offset: 0 atIndex: 3];

    
    [CommandEncoderExtension dispatchMatrix: resultMatrix inCommandEncoder: commandEncoder with: self.pipelineState];

    [commandEncoder endEncoding];
}

-(void)describe
{
    NSLog(@"Spectrogram Input(size: %d) -> Output(size: %d, feautures: %d)", descriptor.inputSize, descriptor.outputSize, descriptor.outputFeatureChannels);
}

@end
