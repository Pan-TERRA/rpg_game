//
//  RPGDuelQuest.h
//  RPG Game
//
//  Created by Максим Шульга on 12/14/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuest.h"

@interface RPGDuelQuest : RPGQuest

@property (nonatomic, copy, readonly) NSString *proofImageStringURL2;
@property (nonatomic, assign, readonly) NSInteger friendID;
@property (nonatomic, copy, readonly) NSString *friendUsername;
@property (nonatomic, assign, readonly) NSInteger daysLeft;
@property (nonatomic, assign, readonly, getter=isWinner) BOOL winner;

- (instancetype)initWithType:(RPGQuestType)aType
                     questID:(NSInteger)aQuestID
                        name:(NSString *)aName
                 description:(NSString *)aQuestDescription
                       state:(RPGQuestState)aState
                      reward:(RPGQuestReward *)aReward
                   getReward:(BOOL)hasGotReward
        proofImageStringURL1:(NSString *)aStringURL1
        proofImageStringURL2:(NSString *)aStringURL2
                    friendID:(NSInteger)aFriendID
              friendUsername:(NSString *)aFriendUsername
                    daysLeft:(NSInteger)aDaysLeft
                      winner:(BOOL)isWinner NS_DESIGNATED_INITIALIZER;
+ (instancetype)duelQuestWithType:(RPGQuestType)aType
                          questID:(NSInteger)aQuestID
                             name:(NSString *)aName
                      description:(NSString *)aQuestDescription
                            state:(RPGQuestState)aState
                           reward:(RPGQuestReward *)aReward
                        getReward:(BOOL)hasGotReward
             proofImageStringURL1:(NSString *)aStringURL1
             proofImageStringURL2:(NSString *)aStringURL2
                         friendID:(NSInteger)aFriendID
                   friendUsername:(NSString *)aFriendUsername
                         daysLeft:(NSInteger)aDaysLeft
                           winner:(BOOL)isWinner;

@end
