//
//  SpectrogramKernel.h
//  audio_test
//
//  Created by Alex on 09.08.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

#import "BaseKernel.h"
#import <Metal/Metal.h>
#import <MetalPerformanceShaders/MetalPerformanceShaders.h>
#import "SpectrogramDescriptor.h"

NS_ASSUME_NONNULL_BEGIN

@interface SpectrogramKernel : BaseKernel

-(instancetype) initWithDevice: (id<MTLDevice>) device
                 andDescriptor: (SpectrogramDescriptor *) descriptor;

-(void) encodeToCommandBuffer: (id<MTLCommandBuffer>) buffer
                  inputVector: (MPSVector * _Nonnull) inputVector
                 resultMatrix: (MPSMatrix * _Nonnull) resultMatrix;

@end

NS_ASSUME_NONNULL_END
