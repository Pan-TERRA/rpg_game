//
//  RPGFriendAddResponse.h
//  RPG Game
//
//  Created by Владислав Крут on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGSerializable.h"
#import "RPGStatusCodes.h"

@interface RPGFriendAddResponse : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) RPGStatusCode status;

- (instancetype)initWithStatus:(RPGStatusCode)aStatus NS_DESIGNATED_INITIALIZER;
+ (instancetype)addFriendResponseWithStatus:(RPGStatusCode)aStatus;

@end
