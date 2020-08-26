//
//  MPSConv1DKernel.h
//  audio_test
//
//  Created by Alex on 05.08.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

#import <Metal/Metal.h>
#import "MASConv1dDescriptor.h"
#import <MetalPerformanceShaders/MetalPerformanceShaders.h>
#import "MASBaseKernel.h"
#import "MASShapedBuffer.h"

NS_ASSUME_NONNULL_BEGIN

@interface MASConv1dKernel: MASBaseKernel

-(instancetype) initWithDevice: (id<MTLDevice>) device
                 andDescriptor: (MASConv1dDescriptor *) descriptor
                       weights: (MASShapedBuffer *) weights
                        biases: (MASShapedBuffer *) biases;

-(void) encodeToCommandBuffer: (id<MTLCommandBuffer>) buffer
                  inputMatrix: (MPSMatrix * _Nonnull) inputMatrix
                 resultMatrix: (MPSMatrix * _Nonnull) resultMatrix;

@end

NS_ASSUME_NONNULL_END
