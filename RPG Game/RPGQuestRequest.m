//
//  RPGQuestRequest.m
//  RPG Game
//
//  Created by Максим Шульга on 10/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestRequest.h"

@interface RPGQuestRequest()

@property (nonatomic, copy, readwrite) NSString *token;
@property (nonatomic, assign, readwrite) NSUInteger questID;

@end

@implementation RPGQuestRequest

- (instancetype)initWithToken:(NSString *)aToken
                      questID:(NSUInteger)aQuestID
{
  self = [super init];
  
  if (self != nil)
  {
    _token = [aToken copy];
    _questID = aQuestID;
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithToken:nil questID:0];
}

+ (instancetype)questRequestWithToken:(NSString *)aToken
                              questID:(NSUInteger)aQuestID
{
  return [[[self alloc] initWithToken:aToken questID:aQuestID] autorelease];
}

@end
