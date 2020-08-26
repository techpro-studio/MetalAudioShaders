//
//  SpectrogramFactory.m
//  audio_test
//
//  Created by Alex on 24.08.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

#import "MASSpectrogramFactory.h"
#import "half.h"

@implementation MASSpectrogramFactory

+(unsigned short) typeSizeFor: (MASSpectrogramDescriptor *)descriptor
{
    return descriptor.useSinglePrecision ? sizeof(float) : sizeof(half);
}

+ (MPSMatrixDescriptor *)outputMatrixDescriptor:(MASSpectrogramDescriptor *)descriptor
{
    return [MPSMatrixDescriptor
            matrixDescriptorWithRows:descriptor.outputFeatureChannels
            columns: descriptor.outputSize
            rowBytes: descriptor.outputSize * [self typeSizeFor: descriptor]
            dataType: descriptor.useSinglePrecision ? MPSDataTypeFloat32 : MPSDataTypeFloat16];
}

@end
