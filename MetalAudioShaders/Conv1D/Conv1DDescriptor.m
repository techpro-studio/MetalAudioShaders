//
//  Conv1DDescriptor.m
//  audio_test
//
//  Created by Alex on 06.08.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

#import "Conv1DDescriptor.h"
#import "half.h"

@implementation Conv1DDescriptor

-(instancetype) initWithKernelSize: (unsigned short) kernelSize
 inputFeatureChannels: (unsigned short) inputFeatureChannels
outputFeatureChannels: (unsigned short) outputFeatureChannels
               stride: (unsigned short) stride
            inputSize: (unsigned short) inputSize
   useSinglePrecision: (BOOL) useSinglePrecision
{
    self = [super init];
    if (self) {
        self.kernelSize = kernelSize;
        self.inputFeatureChannels = inputFeatureChannels;
        self.outputFeatureChannels = outputFeatureChannels;
        self.stride = stride;
        self.inputSize = inputSize;
        self.useSinglePrecision = useSinglePrecision;
        self->_outputSize = ((inputSize - (kernelSize - stride)) / stride) ;
    }
    return self;
}


-(unsigned short) typeSize
{
    return  self.useSinglePrecision ? sizeof(float) : sizeof(half);
}

-(ShapedBuffer *)createWeights
{
    return [[ShapedBuffer alloc] initWithShape:@[@(self.kernelSize), @(self.inputFeatureChannels), @(self.outputFeatureChannels)] andTypeSize: [self typeSize]];
}

- (ShapedBuffer *)createBiases
{
    return  [[ShapedBuffer alloc] initWithShape:@[@(self.outputFeatureChannels)] andTypeSize:[self typeSize]];
}

-(MPSMatrixDescriptor *)inputMatrixDescriptor
{
    return [MPSMatrixDescriptor
            matrixDescriptorWithRows:self.inputFeatureChannels
            columns:self.inputSize
            rowBytes:self.inputSize * [self typeSize]
            dataType: _useSinglePrecision ? MPSDataTypeFloat32 : MPSDataTypeFloat16];
}

-(MPSMatrixDescriptor *)outputMatrixDescriptor
{
    return [MPSMatrixDescriptor
            matrixDescriptorWithRows:self.outputFeatureChannels
            columns:self.outputSize
            rowBytes:self.outputSize * [self typeSize]
            dataType: _useSinglePrecision ? MPSDataTypeFloat32 : MPSDataTypeFloat16];
}

@end
