  //
  //  RPGSkillSelectRequest.h
  //  RPG Game
  //
  //  Created by Максим Шульга on 11/17/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGCharacterRequest.h"

@interface RPGSkillsSelectRequest : RPGCharacterRequest

@property (nonatomic, retain, readonly) NSArray<NSNumber *> *skillsID;

- (instancetype)initWithCharacterID:(NSInteger)aCharacterID
                             skills:(NSArray<NSNumber *> *)aSkills NS_DESIGNATED_INITIALIZER;
+ (instancetype)skillSelectRequestWithCharacterID:(NSInteger)aCharacterID
                                           skills:(NSArray<NSNumber *> *)aSkills;

@end
