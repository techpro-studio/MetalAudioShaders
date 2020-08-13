//
//  SpectrogramDescriptor.h
//  audio_test
//
//  Created by Alex on 09.08.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SpectrogramDescriptor : NSObject

@property (nonatomic, assign) unsigned short nfft;

@property (nonatomic, assign) unsigned short noverlap;

@property (nonatomic, assign) NSUInteger inputSize;

@property (nonatomic, assign) BOOL isComplex;

@property (nonatomic, assign) BOOL useSinglePrecision;

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





@end

NS_ASSUME_NONNULL_END
