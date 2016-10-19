//
//  RPGQuest+Serialization.m
//  RPG Game
//
//  Created by Максим Шульга on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuest+Serialization.h"
#import "RPGQuestReward+Serialization.h"

NSString * const kRPGQuestId = @"id";
NSString * const kRPGQuestName = @"name";
NSString * const kRPGQuestDescription = @"description";
NSString * const kRPGQuestState = @"state";
NSString * const kRPGQuestReward = @"reward";

@implementation RPGQuest (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  dictionaryRepresentation[kRPGQuestId] = @(self.questId);
  dictionaryRepresentation[kRPGQuestName] = self.name;
  dictionaryRepresentation[kRPGQuestDescription] = self.questDescription;
  dictionaryRepresentation[kRPGQuestState] = @(self.state);
  dictionaryRepresentation[kRPGQuestReward] = [self.reward dictionaryRepresentation];
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  NSUInteger questId = [aDictionary[kRPGQuestId] integerValue];
  NSString *name = aDictionary[kRPGQuestName];
  NSString *questDescription = aDictionary[kRPGQuestDescription];
  NSUInteger state = [aDictionary[kRPGQuestState] integerValue];
  RPGQuestReward *reward = [[RPGQuestReward alloc] initWithDictionaryRepresentation:aDictionary[kRPGQuestReward]];
  return [self initWithId:questId name:name description:questDescription state:state reward:reward];
}

@end