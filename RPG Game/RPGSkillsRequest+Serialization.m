//
//  RPGSkillsRequest+Serialization.m
//  RPG Game
//
//  Created by Степан Супинский on 10/28/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillsRequest+Serialization.h"

static NSString * const kRPGSkillsRequestToken = @"token";
static NSString * const kRPGSkillsRequestCharacterID = @"character_id";

@implementation RPGSkillsRequest (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
  dictionary[kRPGSkillsRequestToken] = self.token;
  dictionary[kRPGSkillsRequestCharacterID] = @(self.characterID);
  
  return dictionary;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithToken:aDictionary[kRPGSkillsRequestToken]
                 characterID:[aDictionary[kRPGSkillsRequestCharacterID] integerValue]];
}

@end
