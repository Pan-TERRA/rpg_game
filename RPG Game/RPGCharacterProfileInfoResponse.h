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

@interface RPGCharacterProfileInfoResponse : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) NSInteger status;
@property (nonatomic, copy, readonly) NSString *avatar;
@property (nonatomic, assign, readonly) NSUInteger currentLevel;
@property (nonatomic, assign, readonly) NSUInteger maxExp;
@property (nonatomic, assign, readonly) NSUInteger currentExp;
@property (nonatomic, assign, readonly) NSUInteger attack;
@property (nonatomic, assign, readonly) NSUInteger HP;
@property (nonatomic, assign, readonly) NSUInteger bagSize;
@property (nonatomic, assign, readonly) NSUInteger activeSkillsBagSize;
@property (nonatomic, retain, readonly) NSArray *skills;

- (instancetype)initWithStatus:(NSInteger)aStatus
                        avatar:(NSString *)anAvatar
                  currentLevel:(NSUInteger)aCurrentLevel
                        maxExp:(NSUInteger)aMaxExp
                    currentExp:(NSUInteger)aCurrentExp
                        attack:(NSUInteger)anAttack
                            HP:(NSUInteger)aHP
                       bagSize:(NSUInteger)aBagSize
           activeSkillsBagSize:(NSUInteger)anActiveSkillsBagSize
                        skills:(NSArray *)aSkills NS_DESIGNATED_INITIALIZER;
+ (instancetype)characterProfileInfoResponseWithStatus:(NSInteger)aStatus
                                                avatar:(NSString *)anAvatar
                                          currentLevel:(NSUInteger)aCurrentLevel
                                                maxExp:(NSUInteger)aMaxExp
                                            currentExp:(NSUInteger)aCurrentExp
                                                attack:(NSUInteger)anAttack
                                                    HP:(NSUInteger)aHP
                                               bagSize:(NSUInteger)aBagSize
                                   activeSkillsBagSize:(NSUInteger)anActiveSkillsBagSize
                                                skills:(NSArray *)aSkills;

@end
