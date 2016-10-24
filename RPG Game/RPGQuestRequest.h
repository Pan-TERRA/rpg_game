//
//  RPGQuestRequest.h
//  RPG Game
//
//  Created by Максим Шульга on 10/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPGQuestRequest : NSObject

@property (nonatomic, copy, readonly) NSString *token;
@property (nonatomic, assign, readonly) NSUInteger questID;

- (instancetype)initWithToken:(NSString *)aToken
                      questID:(NSUInteger)aQuestID NS_DESIGNATED_INITIALIZER;
+ (instancetype)questRequestWithToken:(NSString *)aToken
                      questID:(NSUInteger)aQuestID;

@end
