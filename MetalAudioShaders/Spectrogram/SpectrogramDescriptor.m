//
//  SpectrogramDescriptor.m
//  audio_test
//
//  Created by Alex on 09.08.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

#import "SpectrogramDescriptor.h"

@implementation SpectrogramDescriptor


-(instancetype)initWithNfft:(unsigned short)nfft
                   noverlap:(unsigned short)noverlap
                  inputSize:(NSUInteger)inputSize
                  isComplex:(BOOL)isComplex
         useSinglePrecision:(BOOL)useSinglePrecision
{
    self = [super init];
    if (self) {
        self.nfft = nfft;
        self.noverlap = noverlap;
        self.inputSize = inputSize;
        self.isComplex = isComplex;
        self.useSinglePrecision = useSinglePrecision;
        _step = nfft - noverlap;
        _outputSize = (inputSize - noverlap) / _step;
        _outputFeatureChannels = isComplex ? nfft : (nfft / 2) + 1;
    }
    return self;
}

@end
