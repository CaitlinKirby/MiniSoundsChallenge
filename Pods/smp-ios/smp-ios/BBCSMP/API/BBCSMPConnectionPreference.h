//
//  BBCSMPConnectionPreference.h
//  BBCSMP
//
//  Created by Charlotte Hoare on 27/10/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

typedef NS_ENUM(NSInteger, BBCSMPConnectionPreference) {
    BBCSMPConnectionUseServerResponse = 0,
    BBCSMPConnectionPreferSecure,
    BBCSMPConnectionEnforceNonSecure,
    BBCSMPConnectionEnforceSecure,
};
