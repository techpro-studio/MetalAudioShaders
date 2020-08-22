//
//  half.h
//  audio_test
//
//  Created by Alex on 07.08.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

#ifndef half_h
#define half_h

#include <Accelerate/Accelerate.h>

typedef unsigned short half;

static inline void vector_half_to_float(half* src, float *dst, unsigned long size)
{
    vImage_Buffer inputBuff = { src, 1, size, sizeof(half) };
    vImage_Buffer outputBuff = { dst, 1, size, sizeof(float) };
    vImageConvert_Planar16FtoPlanarF(&inputBuff, &outputBuff, 0);
}

static inline void vector_float_to_half(float* src, half *dst, unsigned long size)
{
    vImage_Buffer inputBuff = { src, 1, size, sizeof(float) };
    vImage_Buffer outputBuff = { dst, 1, size, sizeof(half) };
    vImageConvert_PlanarFtoPlanar16F(&inputBuff, &outputBuff, 0);
}


#endif /* half_h */
