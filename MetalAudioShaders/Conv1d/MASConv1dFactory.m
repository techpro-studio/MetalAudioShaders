//
//  Conv1DFactory.m
//  audio_test
//
//  Created by Alex on 24.08.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

#import "MASConv1dFactory.h"
#import "half.h"

@implementation MASConv1dFactory

+(unsigned short) typeSizeFor: (MASConv1dDescriptor *)descriptor
{
    return descriptor.useSinglePrecision ? sizeof(float) : sizeof(half);
}

+(MASShapedBuffer *) fillBuffer:(MASShapedBuffer *) buffer withFile: (NSString *) filePath
{
    if (filePath == nil){
        return buffer;
    }
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    if (data == nil) {
        return buffer;
    }
    memcpy([buffer buffer], [data bytes], [buffer bufferLength]);
    return buffer;
}

+(MASShapedBuffer *)createWeightsFor: (MASConv1dDescriptor *)descriptor withFile: (NSString * _Nullable) path
{
    return [self fillBuffer: [[MASShapedBuffer alloc] initWithShape:@[@(descriptor.kernelSize), @(descriptor.inputFeatureChannels), @(descriptor.outputFeatureChannels)] andTypeSize: [self typeSizeFor: descriptor]] withFile:path];
}

+(MASShapedBuffer *)createBiasesFor: (MASConv1dDescriptor *)descriptor  withFile: (NSString * _Nullable) path
{
    return [self fillBuffer: [[MASShapedBuffer alloc] initWithShape:@[@(descriptor.outputFeatureChannels)] andTypeSize:[self typeSizeFor: descriptor]] withFile:path];
}

+(MPSMatrixDescriptor *)outputMatrixDescriptorFor: (MASConv1dDescriptor *)descriptor
{
    return [MPSMatrixDescriptor
            matrixDescriptorWithRows:descriptor.outputFeatureChannels
            columns:descriptor.outputSize
            rowBytes:descriptor.outputSize * [self typeSizeFor: descriptor]
            dataType: descriptor.useSinglePrecision ? MPSDataTypeFloat32 : MPSDataTypeFloat16];
}

@end
