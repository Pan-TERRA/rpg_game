//
//  RPGDuelQuestRequest.h
//  RPG Game
//
//  Created by Максим Шульга on 12/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestRequest.h"

@interface RPGDuelQuestRequest : RPGQuestRequest

@property (nonatomic, assign, readonly) NSInteger friendID;

- (instancetype)initWithQuestID:(NSInteger)aQuestID
                       friendID:(NSInteger)aFriendID NS_DESIGNATED_INITIALIZER;
+ (instancetype)duelQuestRequestWithQuestID:(NSInteger)aQuestID
                                   friendID:(NSInteger)aFriendID;

@end
