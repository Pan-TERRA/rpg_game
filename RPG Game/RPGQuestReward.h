//
//  RPGQuestReward.h
//  RPG Game
//
//  Created by Максим Шульга on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGSerializable.h"

@interface RPGQuestReward : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) NSUInteger gold;
@property (nonatomic, assign, readonly) NSUInteger crystals;
@property (nonatomic, assign, readonly) NSUInteger skillID;

- (instancetype)initWithGold:(NSUInteger)aGold
                    crystals:(NSUInteger)aCrystals
                     skillID:(NSUInteger)aSkillID NS_DESIGNATED_INITIALIZER;
+ (instancetype)questRewardWithGold:(NSUInteger)aGold
                           crystals:(NSUInteger)aCrystals
                            skillID:(NSUInteger)aSkillID;

@end