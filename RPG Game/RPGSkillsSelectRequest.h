//
//  RPGSkillSelectRequest.h
//  RPG Game
//
//  Created by Максим Шульга on 11/17/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGCharacterRequest.h"

@interface RPGSkillsSelectRequest : RPGCharacterRequest

@property (nonatomic, retain, readonly) NSArray *skillsID;

- (instancetype)initWithToken:(NSString *)aToken
                  characterID:(NSInteger)aCharacterID
                       skills:(NSArray *)aSkills NS_DESIGNATED_INITIALIZER;
+ (instancetype)skillSelectRequestWithToken:(NSString *)aToken
                                characterID:(NSInteger)aCharacterID
                                     skills:(NSArray *)aSkills;

@end
