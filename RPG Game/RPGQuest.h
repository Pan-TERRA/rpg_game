//
//  RPGQuest.h
//  RPG Game
//
//  Created by Максим Шульга on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGSerializable.h"

typedef NS_ENUM(NSUInteger, RPGQuestState)
{
  kRPGQuestStateCanTake,
  kRPGQuestStateInProgress,
  // TODO: rename
  kRPGQuestStateDone,
  kRPGQuestStateReviewedTrue,
  kRPGQuestStateReviewedFalse,
  kRPGQuestStateForReview = 6 // ???: sho
};

@class RPGQuestReward;

@interface RPGQuest : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) NSInteger questID;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *questDescription;
@property (nonatomic, assign, readonly) RPGQuestState state;
@property (nonatomic, retain, readonly) RPGQuestReward *reward;
@property (nonatomic, assign, readonly, getter=hasGotReward) BOOL getReward;
@property (nonatomic, copy, readonly) NSString *proofImageStringURL;

- (instancetype)initWithID:(NSInteger)aQuestID
                      name:(NSString *)aName
               description:(NSString *)aQuestDescription
                     state:(NSUInteger)aState
                    reward:(RPGQuestReward *)aReward
                 getReward:(BOOL)hasGotReward
       proofImageStringURL:(NSString *)aStringURL NS_DESIGNATED_INITIALIZER;
+ (instancetype)questWithID:(NSInteger)aQuestID
                       name:(NSString *)aName
                description:(NSString *)aQuestDescription
                      state:(NSUInteger)aState
                     reward:(RPGQuestReward *)aReward
                  getReward:(BOOL)hasGotReward
        proofImageStringURL:(NSString *)aStringURL;

@end
