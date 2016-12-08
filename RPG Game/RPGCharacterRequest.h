//
//  RPGSkillsRequest.h
//  RPG Game
//
//  Created by Степан Супинский on 10/28/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGSerializable.h"

extern NSString * const kRPGCharacterRequestCharacterID;

@interface RPGCharacterRequest : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) NSInteger characterID;

- (instancetype)initWithCharacterID:(NSInteger)aCharacterID NS_DESIGNATED_INITIALIZER;
+ (instancetype)characterRequestWithCharacterID:(NSInteger)aCharacterID;

@end
