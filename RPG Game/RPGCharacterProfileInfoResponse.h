//
//  RPGCharacterProfileInfoResponse.h
//  RPG Game
//
//  Created by Максим Шульга on 11/17/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
  // Misc
#import "RPGSerializable.h"
  // Entities
@class RPGCharacterProfileSkill;
  // Constants
#import "RPGStatusCodes.h"

@interface RPGCharacterProfileInfoResponse : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) RPGStatusCode status;
@property (nonatomic, assign, readonly) NSUInteger currentLevel;
@property (nonatomic, assign, readonly) NSUInteger maxExp;
@property (nonatomic, assign, readonly) NSUInteger currentExp;
@property (nonatomic, assign, readonly) NSUInteger attack;
@property (nonatomic, assign, readonly) NSUInteger HP;
@property (nonatomic, assign, readonly) NSUInteger bagSize;
@property (nonatomic, assign, readonly) NSUInteger activeSkillsBagSize;
@property (nonatomic, retain, readonly) NSArray<RPGCharacterProfileSkill *> *skills;

- (instancetype)initWithStatus:(RPGStatusCode)aStatus
                  currentLevel:(NSUInteger)aCurrentLevel
                        maxExp:(NSUInteger)aMaxExp
                    currentExp:(NSUInteger)aCurrentExp
                        attack:(NSUInteger)anAttack
                            HP:(NSUInteger)aHP
                       bagSize:(NSUInteger)aBagSize
           activeSkillsBagSize:(NSUInteger)anActiveSkillsBagSize
                        skills:(NSArray<RPGCharacterProfileSkill *> *)aSkills NS_DESIGNATED_INITIALIZER;

+ (instancetype)characterProfileInfoResponseWithStatus:(RPGStatusCode)aStatus
                                          currentLevel:(NSUInteger)aCurrentLevel
                                                maxExp:(NSUInteger)aMaxExp
                                            currentExp:(NSUInteger)aCurrentExp
                                                attack:(NSUInteger)anAttack
                                                    HP:(NSUInteger)aHP
                                               bagSize:(NSUInteger)aBagSize
                                   activeSkillsBagSize:(NSUInteger)anActiveSkillsBagSize
                                                skills:(NSArray<RPGCharacterProfileSkill *> *)aSkills;

@end
