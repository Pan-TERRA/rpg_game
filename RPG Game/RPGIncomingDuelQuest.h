//
//  RPGIncomingDuelQuest.h
//  RPG Game
//
//  Created by Максим Шульга on 12/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
  // Misc
#import "RPGSerializable.h"

@interface RPGIncomingDuelQuest : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) NSInteger questID;
@property (nonatomic, assign, readonly) NSInteger friendID;
@property (nonatomic, copy, readonly) NSString *friendUsername;

- (instancetype)initWithQuestID:(NSInteger)aQuestID
                       friendID:(NSInteger)aFriendID
                 friendUsername:(NSString *)aFriendUsername NS_DESIGNATED_INITIALIZER;
+ (instancetype)incomingDuelQuestWithQuestID:(NSInteger)aQuestID
                                    friendID:(NSInteger)aFriendID
                              friendUsername:(NSString *)aFriendUsername;

@end
