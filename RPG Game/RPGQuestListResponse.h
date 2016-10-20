//
//  RPGQuestListResponse.h
//  RPG Game
//
//  Created by Максим Шульга on 10/17/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPGQuestListResponse : NSObject

@property (nonatomic, assign, readonly) NSInteger status;
@property (nonatomic, retain, readonly) NSArray *quests;

- (instancetype)initWithStatus:(NSInteger)aStatus
                        quests:(NSArray *)aQuests NS_DESIGNATED_INITIALIZER;
+ (instancetype)responseWithStatus:(NSInteger)aStatus
                        quests:(NSArray *)aQuests;

@end
