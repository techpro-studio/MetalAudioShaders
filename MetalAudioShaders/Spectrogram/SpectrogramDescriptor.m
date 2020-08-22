//
//  SpectrogramDescriptor.m
//  audio_test
//
//  Created by Alex on 09.08.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

#import "SpectrogramDescriptor.h"
#import "half.h"

@implementation SpectrogramDescriptor


-(instancetype)initWithNfft:(unsigned short)nfft
                   noverlap:(unsigned short)noverlap
                  inputSize:(NSUInteger)inputSize
                  isComplex:(BOOL)isComplex
         useSinglePrecision:(BOOL)useSinglePrecision
{
    self = [super init];
    if (self) {
        _nfft = nfft;
        _noverlap = noverlap;
        _inputSize = inputSize;
        _isComplex = isComplex;
        _fftNormalizationFactor = 1.0f;
        _useSinglePrecision = useSinglePrecision;
        _step = nfft - noverlap;
        _outputSize = (inputSize - noverlap) / _step;
        _outputFeatureChannels = isComplex ? nfft : (nfft / 2) + 1;
        _window = [[ShapedBuffer alloc] initWithShape:@[@(_nfft)] andTypeSize:[self typeSize]];
        [self setNoWindow];
    }
    return self;
}

-(void) copyToWindow: (float *) buffer
{
    if (_useSinglePrecision){
        memcpy([_window buffer], buffer, sizeof(float) * _nfft);
    } else {
        vector_float_to_half(buffer, [_window buffer], sizeof(half) * _nfft);
    }
}

-(void) setNoWindow
{
    float ones[_nfft];
    for (int i = 0; i < _nfft; ++i)
        ones[i] = 1.0f;
    [self copyToWindow:ones];
}

-(unsigned short) typeSize
{
    return  self.useSinglePrecision ? sizeof(float) : sizeof(half);
}

- (void)setWindowWithType:(WindowType)type
{
    float window[_nfft];
    switch (type) {
        case WindowTypeHann:
            vDSP_hann_window(window, _nfft, 0);
            break;
        case WindowTypeHamming:
            vDSP_hamm_window(window, _nfft, 0);
            break;
        case WindowTypeBlackMan:
            vDSP_blkman_window(window, _nfft, 0);
            break;
    }
    [self copyToWindow: window];
}

@end
