//
//  RPGBattleReward.h
//  RPG Game
//
//  Created by Максим Шульга on 11/25/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGResources.h"
#import "RPGSerializable.h"

@interface RPGBattleReward : RPGResources <RPGSerializable>

@property (nonatomic, assign, readonly) NSInteger exp;

- (instancetype)initWithGold:(NSInteger)aGold
                    crystals:(NSInteger)aCrystals
                         exp:(NSInteger)anExp NS_DESIGNATED_INITIALIZER;
+ (instancetype)battleRewardWithGold:(NSInteger)aGold
                            crystals:(NSInteger)aCrystals
                                 exp:(NSInteger)anExp;

@end
