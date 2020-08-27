//
//  MASMatrixToMPSImageKernel.m
//  MetalAudioShaders
//
//  Created by Alex on 26.08.2020.
//

#import "MASMatrixToMPSImageKernel.h"
#import "MASCommandEncoderExtension.h"

@implementation MASMatrixToMPSImageKernel


- (instancetype)initWithDevice:(id<MTLDevice>)device
            useSinglePrecision: (BOOL) useSinglePrecision
{
    return [super initWithDevice:device functionName: [NSString stringWithFormat:@"matrix_to_image_%@", useSinglePrecision ? @"float" : @"half"]];
}

-(void)encodeToCommandBuffer:(id<MTLCommandBuffer>)commandBuffer
                 inputMatrix:(MPSMatrix *)matrix
                 resultImage:(MPSImage *)image
{
    id<MTLComputeCommandEncoder> commandEncoder = [commandBuffer computeCommandEncoder];
    unsigned short config[2] = {
        matrix.rows,
        matrix.columns
    };
    
    assert(image.height == 1);
    assert(image.width == matrix.columns);
    assert(image.featureChannels == matrix.rows);

    [commandEncoder setComputePipelineState:self.pipelineState];

    [commandEncoder setBytes: &config length:2 * sizeof(unsigned short) atIndex:0];
    [commandEncoder setBuffer: matrix.data offset:0 atIndex:1];
    [commandEncoder setTexture:image.texture atIndex:2];
    

    __auto_type width = self.pipelineState.threadExecutionWidth;
    __auto_type height = self.pipelineState.maxTotalThreadsPerThreadgroup / width;

    MTLSize threadGroupSize = MTLSizeMake(width, height, 1);
    MTLSize threadGroups = MTLSizeMake(
       (matrix.columns + width - 1) / width,
       ((matrix.rows + 3) / 4  + height - 1) / height,
        1
    );

    [commandEncoder dispatchThreadgroups:threadGroups threadsPerThreadgroup: threadGroupSize];

    [commandEncoder endEncoding];
}

@end
