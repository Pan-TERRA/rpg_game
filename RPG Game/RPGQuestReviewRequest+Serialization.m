//
//  RPGQuestReviewRequest+Serialization.m
//  RPG Game
//
//  Created by Максим Шульга on 10/26/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestReviewRequest+Serialization.h"
#import "RPGQuestRequest+Serialization.h"

static NSString * const kRPGQuestReviewRequestResult = @"result";

@implementation RPGQuestReviewRequest (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [[[super dictionaryRepresentation] mutableCopy] autorelease];
  
  dictionaryRepresentation[kRPGQuestReviewRequestResult] = self.token;
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithToken:aDictionary[kRPGQuestRequestToken]
                     questID:[aDictionary[kRPGQuestRequestQuestID] integerValue]
                      result:[aDictionary[kRPGQuestReviewRequestResult] boolValue]];
}
@end
