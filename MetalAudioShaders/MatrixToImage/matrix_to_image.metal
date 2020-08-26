//
//  matrix_to_image.metal
//  MetalAudioShaders
//
//  Created by Alex on 26.08.2020.
//

#include <metal_stdlib>
using namespace metal;


struct Config {
    ushort rows;
    ushort columns;
};

template<typename T>
void matrix_to_image(constant Config& config, constant T* matrixBuffer, texture2d_array<T, metal::access::write> outTexture, ushort2 index[[thread_position_in_grid]]){

    if (index.x >= config.columns || index.y >= config.rows) { return; }
    uint bufferIndex = index.y * config.columns + index.x;
    outTexture.write(matrixBuffer[bufferIndex], ushort2(index.x, 0), index.y);
}


kernel void matrix_to_image_float(constant Config& config, constant float* matrixBuffer, texture2d_array<float, metal::access::write> outTexture, ushort2 index[[thread_position_in_grid]]){
    outTexture.write(vec<float, 4>(2.3, 2.3, 2.3, 2.3), ushort2(index.x, 0), 1);
}


kernel void matrix_to_image_half(constant Config& config, constant half* matrixBuffer, texture2d_array<half, metal::access::write> outTexture, ushort2   index[[thread_position_in_grid]]){
    matrix_to_image(config, matrixBuffer, outTexture, index);
}




