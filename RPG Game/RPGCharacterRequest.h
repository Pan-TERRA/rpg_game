//
//  RPGSkillsRequest.h
//  RPG Game
//
//  Created by Степан Супинский on 10/28/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGRequest.h"
#import "RPGSerializable.h"

extern NSString * const kRPGCharacterRequestToken;
extern NSString * const kRPGCharacterRequestCharacterID;

@interface RPGCharacterRequest : NSObject <RPGSerializable>

@property (copy, nonatomic, readwrite) NSString *token;
@property (assign, nonatomic, readwrite) NSInteger characterID;

- (instancetype)initWithToken:(NSString *)aToken
                  characterID:(NSInteger)aCharacterID NS_DESIGNATED_INITIALIZER;
+ (instancetype)characterRequestWithToken:(NSString *)aToken
                              characterID:(NSInteger)aCharacterID;

@end
