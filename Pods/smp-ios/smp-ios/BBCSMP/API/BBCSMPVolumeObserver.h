//
//  BBCSMPVolumeObserver.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 20/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPObserver.h"
#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPVolumeObserver <BBCSMPObserver>

- (void)playerVolumeChanged:(NSNumber*)volume;

@end

NS_ASSUME_NONNULL_END
