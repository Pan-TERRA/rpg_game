//
//  RPGQuestReviewRequest.m
//  RPG Game
//
//  Created by Максим Шульга on 10/26/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestReviewRequest.h"

@interface RPGQuestReviewRequest ()

@property (nonatomic, assign, readwrite) BOOL result;

@end

@implementation RPGQuestReviewRequest

- (instancetype)initWithToken:(NSString *)aToken
                      questID:(NSUInteger)aQuestID
                       result:(BOOL)aResult
{
  self = [super initWithToken:aToken questID:aQuestID];
  
  if (self != nil)
  {
    _result = aResult;
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithToken:nil questID:0 result:NO];
}

- (instancetype)initWithToken:(NSString *)aToken questID:(NSUInteger)aQuestID
{
  return [self initWithToken:nil questID:0 result:NO];
}

+ (instancetype)questReviewRequestWithToken:(NSString *)aToken
                                    questID:(NSUInteger)aQuestID
                                     result:(BOOL)aResult
{
  return [[[self alloc] initWithToken:aToken questID:aQuestID result:aResult] autorelease];
}

@end
