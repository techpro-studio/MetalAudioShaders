//
//  SpectrogramDescriptor.h
//  audio_test
//
//  Created by Alex on 09.08.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MASShapedBuffer.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum WindowType: NSUInteger {
    WindowTypeHamming = 1,
    WindowTypeHann = 2,
    WindowTypeBlackMan = 3,
} WindowType;



@interface MASSpectrogramDescriptor : NSObject

@property (nonatomic, readonly) unsigned short nfft;

@property (nonatomic, readonly) unsigned short noverlap;

@property (nonatomic, assign) unsigned short fftNormalizationFactor;

@property (nonatomic, readonly) NSUInteger inputSize;

@property (nonatomic, readonly) BOOL isComplex;

@property (nonatomic, readonly) BOOL useSinglePrecision;

@property (nonatomic, retain) MASShapedBuffer *window;

// Size of column or number of rows
@property (nonatomic, readonly) unsigned short outputFeatureChannels;
// Size of row or number of columns
@property (nonatomic, readonly) unsigned short outputSize;

@property (nonatomic, readonly) unsigned short step;

-(instancetype) initWithNfft: (unsigned short) nfft
                    noverlap: (unsigned short) noverlap
                   inputSize: (NSUInteger) inputSize
                   isComplex: (BOOL) isComplex
          useSinglePrecision: (BOOL) useSinglePrecision;


-(void) setWindowWithType: (WindowType) type;


@end

NS_ASSUME_NONNULL_END
