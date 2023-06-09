//
//  BBCSMPPictureInPictureAdapter.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 24/03/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPPictureInPictureAdapter.h"
#import "BBCSMPObserver.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPPictureInPictureObserver;

@interface BBCSMPPictureInPictureController : NSObject <BBCSMPPictureInPictureAdapterDelegate, BBCSMPObserver>

@property (nonatomic, assign, readonly) BOOL supportsPictureInPicture;
@property (nonatomic, strong, nullable) id<BBCSMPPictureInPictureAdapter> adapter;

- (void)addObserver:(id<BBCSMPPictureInPictureObserver>)observer;
- (void)removeObserver:(id<BBCSMPPictureInPictureObserver>)observer;

- (void)startPictureInPicture;
- (void)stopPictureInPictureWithCompletionHandler:(nullable void (^)(void))completionHandler;

@end

NS_ASSUME_NONNULL_END
