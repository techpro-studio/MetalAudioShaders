//
//  MASMatrixToMPSImageKernel.h
//  MetalAudioShaders
//
//  Created by Alex on 26.08.2020.
//

#import <Foundation/Foundation.h>
#import <MetalPerformanceShaders/MetalPerformanceShaders.h>
#import <Metal/Metal.h>
#import "MASBaseKernel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MASMatrixToMPSImageKernel : MASBaseKernel


-(instancetype) initWithDevice:(id<MTLDevice>)device
            useSinglePrecision: (BOOL) useSinglePrecision;

-(void) encodeToCommandBuffer: (id<MTLCommandBuffer>) commandBuffer
                  inputMatrix: (MPSMatrix *)matrix
                  resultImage: (MPSImage *) image;

@end

NS_ASSUME_NONNULL_END
