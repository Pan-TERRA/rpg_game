//
//  RPGQuestReviewRequest.h
//  RPG Game
//
//  Created by Максим Шульга on 10/26/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestRequest.h"

@interface RPGQuestReviewRequest : RPGQuestRequest

@property (nonatomic, assign, readonly) BOOL result;

- (instancetype)initWithQuestID:(NSUInteger)aQuestID
                       result:(BOOL)aResult NS_DESIGNATED_INITIALIZER;
+ (instancetype)questReviewRequestWithQuestID:(NSUInteger)aQuestID
                                     result:(BOOL)aResult;

@end
