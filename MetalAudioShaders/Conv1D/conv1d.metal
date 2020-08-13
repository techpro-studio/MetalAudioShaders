//
//  conv1d.metal
//  audio_test
//
//  Created by Alex on 06.08.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

struct Config {
    ushort kernelSize;
    ushort inputFeatureChannels;
    ushort outputFeatureChannels;
    ushort stride;
    ushort inputSize;
    ushort outputSize;
};

template<typename T>
T compute_conv1d_kernel(constant T* rowPtr, constant T *weightsPtr, ushort kernelSize)
{
    T sum = 0.0h;
    ushort iterations = kernelSize / 4;
    for (ushort i = 0; i < iterations; ++i)
    {
        vec<T, 4> row = ((constant vec<T, 4>*) rowPtr)[i];
        vec<T, 4> weights = ((constant vec<T, 4>*) weightsPtr)[i];
        sum += dot(row, weights);
    }
    ushort left = kernelSize % 4;
    for (ushort i = 0; i < left; ++i)
    {
        sum += rowPtr[iterations * 4 + i] * weightsPtr[iterations * 4 + i];
    }
    return sum;
}

template<typename T>
void compute_conv1d(constant Config & config, constant T* inputBuffer, device T* output, constant T* weights, constant T* biasTerms, ushort2 index)
{
    if (index.y >= config.outputFeatureChannels || index.x >= config.outputSize) {
        return;
    }
    uint outputFeatureWeightsOffset = config.kernelSize * config.inputFeatureChannels * index.y;
    constant T* outputFeatureWeights = weights + outputFeatureWeightsOffset;

    ushort inputRowOffset = index.x * config.stride;

    T result = 0.0h;

    for (ushort i = 0; i < config.inputFeatureChannels; ++i)
    {
        constant T* rowPtr = inputBuffer + (i * config.inputSize) + inputRowOffset;
        constant T* weightsPtr = outputFeatureWeights + (i * config.kernelSize);
        result += compute_conv1d_kernel(rowPtr, weightsPtr, config.kernelSize);
    }

    uint outputIndex = (index.y * config.outputSize) + index.x;

    result += biasTerms[index.y];

    output[outputIndex] = result;
}


kernel void conv1d_half(constant Config & config, constant half* inputBuffer [[buffer(1)]], device half* output [[buffer(2)]], constant half* weights [[buffer(3)]], constant half* biasTerms [[buffer(4)]], ushort2 index[[thread_position_in_grid]])
{
    compute_conv1d(config, inputBuffer, output, weights, biasTerms, index);
}


kernel void conv1d_float(constant Config & config, constant float* inputBuffer [[buffer(1)]], device float* output [[buffer(2)]], constant float* weights [[buffer(3)]], constant float* biasTerms [[buffer(4)]], ushort2 index[[thread_position_in_grid]])
{
    compute_conv1d(config, inputBuffer, output, weights, biasTerms, index);
}


