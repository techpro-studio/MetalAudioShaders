//
//  Tensor.m
//  audio_test
//
//  Created by Alex on 09.08.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

#import "ShapedBuffer.h"

@implementation ShapedBuffer
{
    NSArray<NSNumber *> *shape;
    void *ptr;
}

-(NSArray<NSNumber *> *)shape
{
    return shape;
}

-(void *) buffer
{
    return ptr;
}

-(instancetype)initWithShape: (NSArray<NSNumber *> *) shape
                 andTypeSize: (unsigned short) typeSize
{
    self = [super init];
    if (self) {
        self -> shape = shape;
        size_t size = typeSize;
        for (NSNumber *item in shape)
        {
            size *= item.unsignedIntValue;
        }
        ptr = malloc(size);

    }
    return self;
}

- (void)dealloc
{
    free(ptr);
}


@end
