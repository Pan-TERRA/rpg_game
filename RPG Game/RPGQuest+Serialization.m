//
//  RPGQuest+Serialization.m
//  RPG Game
//
//  Created by Максим Шульга on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuest+Serialization.h"
#import "RPGQuestReward+Serialization.h"

NSString * const kRPGQuestID = @"quest_id";
NSString * const kRPGQuestName = @"name";
NSString * const kRPGQuestDescription = @"description";
NSString * const kRPGQuestState = @"state";
NSString * const kRPGQuestReward = @"reward";
NSString * const kRPGQuestProofImageStringURL = @"prove_image";

@implementation RPGQuest (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  dictionaryRepresentation[kRPGQuestID] = @(self.questID);
  dictionaryRepresentation[kRPGQuestName] = self.name;
  dictionaryRepresentation[kRPGQuestDescription] = self.questDescription;
  dictionaryRepresentation[kRPGQuestState] = @(self.state);
  dictionaryRepresentation[kRPGQuestReward] = [self.reward dictionaryRepresentation];
  if (self.proofImageStringURL)
  {
    dictionaryRepresentation[kRPGQuestProofImageStringURL] = self.proofImageStringURL;
  }
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  NSUInteger questID = [aDictionary[kRPGQuestID] integerValue];
  NSString *name = aDictionary[kRPGQuestName];
  NSString *questDescription = aDictionary[kRPGQuestDescription];
  NSUInteger state = [aDictionary[kRPGQuestState] integerValue];
  NSString *proofImageStringURL = aDictionary[kRPGQuestProofImageStringURL];
  
  RPGQuestReward *reward = [[[RPGQuestReward alloc] initWithDictionaryRepresentation:aDictionary[kRPGQuestReward]] autorelease];
  
  return [self initWithID:questID name:name description:questDescription state:state reward:reward proofImageStringURL:proofImageStringURL];
}

@end
