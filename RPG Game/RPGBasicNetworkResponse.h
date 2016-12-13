//
//  RPGBasicNetworkResponse.h
//  RPG Game
//
//  Created by Степан Супинский on 11/18/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
  // Misc
#import "RPGSerializable.h"
  // Constants
#import "RPGStatusCodes.h"

extern NSString * const kRPGBasicNetworkResponseStatus;

@interface RPGBasicNetworkResponse : NSObject <RPGSerializable>

@property (assign, nonatomic, readonly) RPGStatusCode status;

- (instancetype)initWithStatus:(RPGStatusCode)aStatus NS_DESIGNATED_INITIALIZER;
+ (instancetype)responseWithStatus:(RPGStatusCode)aStatus;

@end
