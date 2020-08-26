//
//  BaseKernel.h
//  audio_test
//
//  Created by Alex on 09.08.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Metal/Metal.h>


NS_ASSUME_NONNULL_BEGIN

@interface MASBaseKernel : NSObject

@property (readonly, nonatomic) id<MTLComputePipelineState> pipelineState;

@property (readonly, nonatomic) id<MTLDevice> device;

-(instancetype) initWithDevice: (id<MTLDevice>) device functionName: (NSString *) functionName;

-(void) describe;

@end

NS_ASSUME_NONNULL_END
