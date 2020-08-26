//
//  MatrixKernel.h
//  audio_test
//
//  Created by Alex on 10.08.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

#import "MASBaseKernel.h"
#import <MetalPerformanceShaders/MetalPerformanceShaders.h>


NS_ASSUME_NONNULL_BEGIN

@interface MASCommandEncoderExtension: NSObject

+(void)dispatchMatrix: (MPSMatrix *)matrix
     inCommandEncoder: (id<MTLComputeCommandEncoder>) commandEncoder
                 with: (id<MTLComputePipelineState>) pipelineState;


@end

NS_ASSUME_NONNULL_END
