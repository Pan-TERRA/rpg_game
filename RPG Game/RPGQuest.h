//
//  RPGQuest.h
//  RPG Game
//
//  Created by Максим Шульга on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RPGQuestReward;

@interface RPGQuest : NSObject

@property (nonatomic, assign, readonly) NSUInteger questId;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *questDescription;
@property (nonatomic, assign, readonly) NSUInteger state;
@property (nonatomic, retain, readonly) RPGQuestReward *reward;

- (instancetype)initWithId:(NSUInteger)questId
                      name:(NSString *)name
               description:(NSString *)questDescription
                     state:(NSUInteger)state
                    reward:(RPGQuestReward *)reward NS_DESIGNATED_INITIALIZER;

+ (instancetype)responseWithId:(NSUInteger)questId
                          name:(NSString *)name
                   description:(NSString *)questDescription
                         state:(NSUInteger)state
                        reward:(RPGQuestReward *)reward;

@end