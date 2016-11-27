//
//  RPGRequest.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
  // Misc
#import "RPGSerializable.h"

extern NSString *const kRPGRequestSerializationType;

/**
 *  Basic request class. Mainly used for static requests and "RPGBattleController"
 *  socket messages.
 */
@interface RPGRequest : NSObject <RPGSerializable>

@property (nonatomic, copy, readonly) NSString *type;

#pragma mark - Init

- (instancetype)initWithType:(NSString *)aType NS_DESIGNATED_INITIALIZER;
+ (instancetype)requestWithType:(NSString *)aType;

@end
