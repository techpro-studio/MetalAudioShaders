//
//  BaseKernel.m
//  audio_test
//
//  Created by Alex on 09.08.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

#import "MASBaseKernel.h"
#import <MetalPerformanceShaders/MetalPerformanceShaders.h>

@interface MASBaseKernel ()

@property (readwrite, nonatomic) id<MTLDevice> device;

@property (readwrite, nonatomic) id<MTLComputePipelineState> pipelineState;

@end


@implementation MASBaseKernel

-(instancetype)initWithDevice:(id<MTLDevice>)device functionName:(nonnull NSString *)functionName
{
    self = [super init];
    if (self) {
        self.device = device;

        __auto_type library = [device newDefaultLibrary];

        if (library == nil) {
            @throw [NSException exceptionWithName:@"no library" reason:@"library not found" userInfo:nil];
        }

        __auto_type function = [library newFunctionWithName:functionName];

        if (function == nil) {
            @throw [NSException exceptionWithName:@"no function" reason:[NSString stringWithFormat:@"Function with name '%@' not found", functionName] userInfo:nil];
        }
        NSError *error;

        self.pipelineState = [device newComputePipelineStateWithFunction:function error:&error];

        if (error != nil) {
            @throw [NSException exceptionWithName:@"Pipeline state failed" reason:error.localizedDescription userInfo:nil];
        }
    }
    return self;
}

-(void) describe
{
    NSLog(@"Base kernel");
}

@end

