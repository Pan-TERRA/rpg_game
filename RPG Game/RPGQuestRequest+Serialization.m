//
//  RPGQuestRequest+Serialization.m
//  RPG Game
//
//  Created by Максим Шульга on 10/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestRequest+Serialization.h"

static NSString * const kRPGQuestRequestToken = @"token";
static NSString * const kRPGQuestRequestQuestID = @"quest_id";

@implementation RPGQuestRequest (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGQuestRequestToken] = self.token;
  dictionaryRepresentation[kRPGQuestRequestQuestID] = @(self.questID);
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithToken:aDictionary[kRPGQuestRequestToken]
                     questID:[aDictionary[kRPGQuestRequestQuestID] integerValue]];
}

@end
