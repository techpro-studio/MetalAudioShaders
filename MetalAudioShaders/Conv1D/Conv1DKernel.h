//
//  MPSConv1DKernel.h
//  audio_test
//
//  Created by Alex on 05.08.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

#import <Metal/Metal.h>
#import "Conv1DDescriptor.h"
#import <MetalPerformanceShaders/MetalPerformanceShaders.h>
#import "BaseKernel.h"
#import "ShapedBuffer.h"

NS_ASSUME_NONNULL_BEGIN

@interface Conv1DKernel: BaseKernel

-(instancetype) initWithDevice: (id<MTLDevice>) device
                 andDescriptor: (Conv1DDescriptor *) descriptor
                       weights: (ShapedBuffer *) weights
                        biases: (ShapedBuffer *) biases;

-(void) encodeToCommandBuffer: (id<MTLCommandBuffer>) buffer
                  inputMatrix: (MPSMatrix * _Nonnull) inputMatrix
                 resultMatrix: (MPSMatrix * _Nonnull) resultMatrix;

@end

NS_ASSUME_NONNULL_END
