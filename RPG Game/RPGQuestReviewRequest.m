//
//  RPGQuestReviewRequest.m
//  RPG Game
//
//  Created by Максим Шульга on 10/26/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestReviewRequest.h"

static NSString * const kRPGQuestReviewRequestResult = @"result";

@interface RPGQuestReviewRequest ()

@property (nonatomic, assign, readwrite) BOOL result;

@end

@implementation RPGQuestReviewRequest

- (instancetype)initWithQuestID:(NSUInteger)aQuestID
                         result:(BOOL)aResult
{
  self = [super initWithQuestID:aQuestID];
  
  if (self != nil)
  {
    _result = aResult;
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithQuestID:0 result:NO];
}

- (instancetype)initWithQuestID:(NSUInteger)aQuestID
{
  return [self initWithQuestID:0 result:NO];
}

+ (instancetype)questReviewRequestWithQuestID:(NSUInteger)aQuestID
                                       result:(BOOL)aResult
{
  return [[[self alloc] initWithQuestID:aQuestID result:aResult] autorelease];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [[[super dictionaryRepresentation] mutableCopy] autorelease];
  
  dictionaryRepresentation[kRPGQuestReviewRequestResult] = @(self.result);
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithQuestID:[aDictionary[kRPGQuestRequestQuestID] integerValue]
                      result:[aDictionary[kRPGQuestReviewRequestResult] boolValue]];
}


@end
