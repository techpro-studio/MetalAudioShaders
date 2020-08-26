//
//  Conv1DDescriptor.m
//  audio_test
//
//  Created by Alex on 06.08.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

#import "MASConv1dDescriptor.h"
#import "half.h"

@implementation MASConv1dDescriptor

-(instancetype) initWithKernelSize: (unsigned short) kernelSize
 inputFeatureChannels: (unsigned short) inputFeatureChannels
outputFeatureChannels: (unsigned short) outputFeatureChannels
               stride: (unsigned short) stride
            inputSize: (unsigned short) inputSize
   useSinglePrecision: (BOOL) useSinglePrecision
{
    self = [super init];
    if (self) {
        self.kernelSize = kernelSize;
        self.inputFeatureChannels = inputFeatureChannels;
        self.outputFeatureChannels = outputFeatureChannels;
        self.stride = stride;
        self.inputSize = inputSize;
        self.useSinglePrecision = useSinglePrecision;
        self->_outputSize = ((inputSize - (kernelSize - stride)) / stride) ;
    }
    return self;
}


@end
