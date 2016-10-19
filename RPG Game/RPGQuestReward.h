//
//  RPGQuestReward.h
//  RPG Game
//
//  Created by Максим Шульга on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPGQuestReward : NSObject

@property (nonatomic, assign, readonly) NSUInteger gold;
@property (nonatomic, assign, readonly) NSUInteger crystals;
@property (nonatomic, assign, readonly) NSUInteger skillId;

- (instancetype)initWithGold:(NSUInteger)gold
                    crystals:(NSUInteger)crystals
                     skillId:(NSUInteger)skillId NS_DESIGNATED_INITIALIZER;
+ (instancetype)responseWithGold:(NSUInteger)gold
                        crystals:(NSUInteger)crystals
                         skillId:(NSUInteger)skillId;

@end