//
//  SpectrogramFactory.h
//  audio_test
//
//  Created by Alex on 24.08.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MetalPerformanceShaders/MetalPerformanceShaders.h>
#import "MASSpectrogramDescriptor.h"

NS_ASSUME_NONNULL_BEGIN

@interface MASSpectrogramFactory : NSObject

+(MPSMatrixDescriptor*) outputMatrixDescriptor: (MASSpectrogramDescriptor *) descriptor;

@end

NS_ASSUME_NONNULL_END
