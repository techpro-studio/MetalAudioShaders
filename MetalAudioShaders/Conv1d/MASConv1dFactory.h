//
//  Conv1DFactory.h
//  audio_test
//
//  Created by Alex on 24.08.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MetalPerformanceShaders/MetalPerformanceShaders.h>
#import "MASShapedBuffer.h"
#import "MASConv1dDescriptor.h"

NS_ASSUME_NONNULL_BEGIN

@interface MASConv1dFactory : NSObject

+(MASShapedBuffer *) createWeightsFor: (MASConv1dDescriptor *)descriptor withFile: (NSString * _Nullable) path;
+(MASShapedBuffer *) createBiasesFor: (MASConv1dDescriptor *)descriptor withFile: (NSString * _Nullable) path;

+(MPSMatrixDescriptor *) outputMatrixDescriptorFor: (MASConv1dDescriptor *)descriptor;

@end

NS_ASSUME_NONNULL_END
