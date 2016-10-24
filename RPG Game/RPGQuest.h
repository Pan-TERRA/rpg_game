//
//  RPGQuest.h
//  RPG Game
//
//  Created by Максим Шульга on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, RPGQuestState)
{
  kRPGQuestStateCanTake,
  kRPGQuestStateInProgress,
  kRPGQuestStateDone,
  kRPGQuestStateReviewedFalse,
  kRPGQuestStateReviewedTrue,
  kRPGQuestStateHide,
  kRPGQuestStateForReview
};

@class RPGQuestReward;

@interface RPGQuest : NSObject

@property (nonatomic, assign, readonly) NSUInteger questID;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *questDescription;
@property (nonatomic, assign, readonly) RPGQuestState state;
@property (nonatomic, retain, readonly) RPGQuestReward *reward;

- (instancetype)initWithID:(NSUInteger)aQuestID
                      name:(NSString *)aName
               description:(NSString *)aQuestDescription
                     state:(NSUInteger)aState
                    reward:(RPGQuestReward *)aReward NS_DESIGNATED_INITIALIZER;

+ (instancetype)questWithID:(NSUInteger)aQuestID
                       name:(NSString *)aName
                description:(NSString *)aQuestDescription
                      state:(NSUInteger)aState
                     reward:(RPGQuestReward *)aReward;

@end