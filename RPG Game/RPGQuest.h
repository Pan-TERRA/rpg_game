//
//  RPGQuest.h
//  RPG Game
//
//  Created by Максим Шульга on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
  // Misc
#import "RPGSerializable.h"
  // Entities
@class RPGQuestReward;
  // Constants
#import "RPGQuestEnum.h"

extern NSString * const kRPGQuestType;
extern NSString * const kRPGQuestID;
extern NSString * const kRPGQuestName;
extern NSString * const kRPGQuestDescription;
extern NSString * const kRPGQuestState;
extern NSString * const kRPGQuestReward;
extern NSString * const kRPGQuestGetReward;
extern NSString * const kRPGQuestProofImageStringURL1;

@interface RPGQuest : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) RPGQuestType questType;

@property (nonatomic, assign, readonly) NSInteger questID;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *questDescription;
@property (nonatomic, assign, readonly) RPGQuestState state;
@property (nonatomic, retain, readonly) RPGQuestReward *reward;
@property (nonatomic, assign, readonly, getter=hasGotReward) BOOL getReward;
@property (nonatomic, copy, readonly) NSString *proofImageStringURL1;



- (instancetype)initWithType:(RPGQuestType)aType
                     questID:(NSInteger)aQuestID
                        name:(NSString *)aName
                 description:(NSString *)aQuestDescription
                       state:(RPGQuestState)aState
                      reward:(RPGQuestReward *)aReward
                   getReward:(BOOL)hasGotReward
        proofImageStringURL1:(NSString *)aStringURL1 NS_DESIGNATED_INITIALIZER;
+ (instancetype)questWithType:(RPGQuestType)aType
                      questID:(NSInteger)aQuestID
                         name:(NSString *)aName
                  description:(NSString *)aQuestDescription
                        state:(RPGQuestState)aState
                       reward:(RPGQuestReward *)aReward
                    getReward:(BOOL)hasGotReward
         proofImageStringURL1:(NSString *)aStringURL1;

@end
