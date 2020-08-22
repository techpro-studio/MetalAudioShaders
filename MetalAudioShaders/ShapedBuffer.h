//
//  Tensor.h
//  audio_test
//
//  Created by Alex on 09.08.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShapedBuffer : NSObject

-(instancetype) initWithShape: (NSArray<NSNumber *> *) shape andTypeSize: (unsigned short) typeSize;

-(NSArray<NSNumber *> *) shape;

-(NSUInteger) bufferLength;

-(void *) buffer;

@end

NS_ASSUME_NONNULL_END
