//
//  ReactNativeVolumeController.m
//  ReactNativeVolumeController
//
//  Created by Tyler Malone on 03/18/19.
//  Copyright © 2019. All rights reserved.
//

#import "RNVolumeControl.h"
#import "JPSVolumeButtonHandler.h"

#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@implementation RNVolumeControl {
    JPSVolumeButtonHandler *volumeHandler;
    bool hasListeners;
}

RCT_EXPORT_MODULE(VolumeControl)

- (NSArray<NSString *> *)supportedEvents
{
    return @[@"VolumeChanged"];
}

- (instancetype)init{
    self = [super init];
    __weak typeof(self) weakSelf = self;
    volumeHandler = [JPSVolumeButtonHandler volumeButtonHandlerWithUpBlock:^{
        [weakSelf sendEventWithName:@"VolumeChanged" body:@{@"volume": [NSNumber numberWithFloat: 0.0]}];
    } downBlock:^{
        [weakSelf sendEventWithName:@"VolumeChanged" body:@{@"volume": [NSNumber numberWithFloat: 0.0]}];
    }];
    [volumeHandler startHandler:YES];
    return self;
}

- (void)startObserving {
    hasListeners = YES;
}

- (void)stopObserving {
    hasListeners = NO;
}

+ (BOOL) requiresMainQueueSetup {
    return YES;
}

- (void)dealloc {
    [volumeHandler stopHandler];
    volumeHandler = nil;
}

@end
