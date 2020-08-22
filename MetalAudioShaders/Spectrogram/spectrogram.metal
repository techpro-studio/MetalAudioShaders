//
//  new_shaders.metal
//  audio_test
//
//  Created by Alex on 06.08.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

struct Config {
    ushort outputFeatureChannels;
    ushort outputSize;
    ushort nfft;
    ushort step;
    float normalizationFactor;
};

template<typename T>
constexpr T pi(){
    if (is_same<T, half>::value){
        return M_PI_H;
    } else {
        return M_PI_F;
    }
}

template<typename T>
vec<T, 2> real_dft_step(constant T *input, constant T* window, ushort k, ushort nfft){
    vec<T, 2> value {0.h, 0.h};
    for (int n = 0; n < nfft; ++n) {
        T windowFactor = window[n];
        T angle = 2 * pi<T>() * n * k / nfft;
        value += { *(input + n) * windowFactor * cos(angle), -1 * *(input + n) * windowFactor * sin(angle) };
    }
    return value;
}

template<typename T>
vec<T, 2> complex_dft_step(constant vec<T, 2> *input, constant T* window,  ushort k, ushort nfft){
    vec<T, 2> value {0, 0};
    for (int n = 0; n < nfft; ++n) {
        T windowFactor = window[n];
        T angle = 2 * pi<T>() * n * k / nfft;
        vec<T, 2> inputN = *(input + n);
        value += { inputN[0] * windowFactor * cos(angle) + inputN[1] * windowFactor * sin(angle) , -1 * inputN[0] * windowFactor * sin(angle) + inputN[1] * windowFactor * cos(angle) };
    }
    return value;
}

template<typename T>
T calculate_magnitude(vec<T, 2> complex) {
    T magnitude = sqrt(complex[0] * complex[0] + complex[1] * complex[1]);
    magnitude += 5.9605e-8h;
    T result = 10.0h * log10(magnitude);
    return result;
}

template<typename T>
void spectrogram_real(constant Config& config, constant T* window, constant T *input, device T *output, ushort2 index[[thread_position_in_grid]])
{
    if (index.x >= config.outputSize || index.y >= config.outputFeatureChannels) { return; }
    constant T *input_begin = input + index.x * config.step;
    vec<T, 2> dft = real_dft_step(input_begin, window, index.y, config.nfft);
    dft *= (T) config.normalizationFactor;
    uint outputIndex = index.y * config.outputSize + index.x;
    output[outputIndex] = calculate_magnitude(dft);
}

template<typename T>
void spectrogram_complex(constant Config& config, constant T* window, constant vec<T, 2> *input, device T *output, ushort2 index[[thread_position_in_grid]])
{
    if (index.x >= config.outputSize || index.y >= config.outputFeatureChannels) { return; }
    constant vec<T, 2> *input_begin = input + index.x * config.step;
    vec<T, 2> dft = complex_dft_step(input_begin, window, index.y, config.nfft);
    dft *= (T) config.normalizationFactor;
    uint outputIndex = index.y * config.outputSize + index.x;
    output[outputIndex] = calculate_magnitude(dft);
}

kernel void spectrogram_real_half(constant Config& config, constant half* window, constant half *input,  device half *output, ushort2 index[[thread_position_in_grid]])
{
    spectrogram_real(config, window, input, output, index);
}

kernel void spectrogram_real_float(constant Config& config, constant float* window, constant float *input,  device float *output, ushort2 index[[thread_position_in_grid]])
{
    spectrogram_real(config, window, input, output, index);
}

kernel void spectrogram_complex_half(constant Config& config, constant half* window, constant half2 *input,  device half *output, ushort2 index[[thread_position_in_grid]])
{
    spectrogram_complex(config, window, input, output, index);
}

kernel void spectrogram_complex_float(constant Config& config, constant float* window, constant float2 *input, device float *output, ushort2 index[[thread_position_in_grid]])
{
    spectrogram_complex(config, window, input, output, index);
}




