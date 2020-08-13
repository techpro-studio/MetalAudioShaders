//
//  SpectrogramKernel.m
//  audio_test
//
//  Created by Alex on 09.08.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

#import "SpectrogramKernel.h"
#import "CommandEncoderExtension.h"

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

    unsigned short config[4] = {
        descriptor.outputFeatureChannels,
        descriptor.outputSize,
        descriptor.nfft,
        descriptor.step,
    };

    [commandEncoder setComputePipelineState: self.pipelineState];
    [commandEncoder setBytes: &config length: 4 * sizeof(unsigned short) atIndex: 0];
    [commandEncoder setBuffer: inputVector.data offset: 0 atIndex: 1];
    [commandEncoder setBuffer: resultMatrix.data offset: 0 atIndex: 2];


    [CommandEncoderExtension dispatchMatrix: resultMatrix inCommandEncoder: commandEncoder with: self.pipelineState];

    [commandEncoder endEncoding];
}

-(void)describe
{
    NSLog(@"Spectrogram Input(size: %lu) -> Output(size: %d, feautures: %d)", (unsigned long)descriptor.inputSize, descriptor.outputSize, descriptor.outputFeatureChannels);
}

@end
