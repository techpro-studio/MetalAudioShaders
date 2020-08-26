//
//  SpectrogramKernel.h
//  audio_test
//
//  Created by Alex on 09.08.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

#import "MASBaseKernel.h"
#import <Metal/Metal.h>
#import <MetalPerformanceShaders/MetalPerformanceShaders.h>
#import "MASSpectrogramDescriptor.h"

NS_ASSUME_NONNULL_BEGIN

@interface MASSpectrogramKernel : MASBaseKernel

-(instancetype) initWithDevice: (id<MTLDevice>) device
                 andDescriptor: (MASSpectrogramDescriptor *) descriptor;

-(void) encodeToCommandBuffer: (id<MTLCommandBuffer>) buffer
                  inputVector: (MPSVector * _Nonnull) inputVector
                 resultMatrix: (MPSMatrix * _Nonnull) resultMatrix;

@end

NS_ASSUME_NONNULL_END
