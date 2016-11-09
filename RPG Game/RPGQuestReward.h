//
//  RPGQuestReward.h
//  RPG Game
//
//  Created by Максим Шульга on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGResources.h"

@interface RPGQuestReward : RPGResources

@property (nonatomic, assign, readonly) NSUInteger skillID;

- (instancetype)initWithGold:(NSInteger)aGold
                    crystals:(NSInteger)aCrystals
                     skillID:(NSUInteger)aSkillID NS_DESIGNATED_INITIALIZER;
+ (instancetype)questRewardWithGold:(NSInteger)aGold
                           crystals:(NSInteger)aCrystals
                            skillID:(NSUInteger)aSkillID;

@end
