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

@interface RPGBasicNetworkResponse : NSObject <RPGSerializable>

@property (assign, nonatomic, readonly) NSInteger status;

- (instancetype)initWithStatus:(NSInteger)aStatus NS_DESIGNATED_INITIALIZER;
+ (instancetype)responseWithStatus:(NSInteger)aStatus;

@end
