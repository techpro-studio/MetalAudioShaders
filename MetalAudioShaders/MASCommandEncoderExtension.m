//
//  MatrixKernel.m
//  audio_test
//
//  Created by Alex on 10.08.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

#import "MASCommandEncoderExtension.h"

@implementation MASCommandEncoderExtension

+(void)dispatchMatrix: (MPSMatrix *)matrix
     inCommandEncoder: (id<MTLComputeCommandEncoder>) commandEncoder
                 with: (id<MTLComputePipelineState>) pipelineState
{
    __auto_type width = pipelineState.threadExecutionWidth;
    __auto_type height = pipelineState.maxTotalThreadsPerThreadgroup / width;

    MTLSize threadGroupSize = MTLSizeMake(width, height, 1);
    MTLSize threadGroups = MTLSizeMake(
       (matrix.columns + width - 1) / width,
       (matrix.rows + height - 1) / height,
        1
    );

    [commandEncoder dispatchThreadgroups:threadGroups threadsPerThreadgroup: threadGroupSize];
}


@end
