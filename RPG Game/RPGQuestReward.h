//
//  RPGQuestReward.h
//  RPG Game
//
//  Created by Максим Шульга on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGResources.h"
#import "RPGSerializable.h"

@interface RPGQuestReward : RPGResources <RPGSerializable>

@property (nonatomic, assign, readonly) NSInteger skillID;

- (instancetype)initWithGold:(NSInteger)aGold
                    crystals:(NSInteger)aCrystals
                     skillID:(NSInteger)aSkillID NS_DESIGNATED_INITIALIZER;
+ (instancetype)questRewardWithGold:(NSInteger)aGold
                           crystals:(NSInteger)aCrystals
                            skillID:(NSInteger)aSkillID;

@end
