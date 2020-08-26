//
//  Conv1DDescriptor.h
//  audio_test
//
//  Created by Alex on 06.08.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MASShapedBuffer.h"
#import <MetalPerformanceShaders/MetalPerformanceShaders.h>

NS_ASSUME_NONNULL_BEGIN


@interface MASConv1dDescriptor : NSObject

@property (nonatomic, assign) unsigned short kernelSize;
@property (nonatomic, assign) unsigned short inputFeatureChannels;
@property (nonatomic, assign) unsigned short outputFeatureChannels;
@property (nonatomic, assign) unsigned short stride;
@property (nonatomic, assign) unsigned short inputSize;
@property (nonatomic, readonly) unsigned short outputSize;
@property (nonatomic, assign) BOOL useSinglePrecision;

-(instancetype) initWithKernelSize: (unsigned short) kernelSize
              inputFeatureChannels: (unsigned short) inputFeatureChannels
             outputFeatureChannels: (unsigned short) outputFeatureChannels
                            stride: (unsigned short) stride
                         inputSize: (unsigned short) inputSize
                useSinglePrecision: (BOOL) useSinglePrecision;




@end

NS_ASSUME_NONNULL_END
