//
//  RPGQuestListResponse+Serialization.m
//  RPG Game
//
//  Created by Максим Шульга on 10/18/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestListResponse+Serialization.h"
#import "RPGQuest+Serialization.h"

NSString * const kRPGQuestListResponseStatus = @"status";
NSString * const kRPGQuestListResponseQuests = @"quests";

@implementation RPGQuestListResponse (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  dictionaryRepresentation[kRPGQuestListResponseStatus] = @(self.status);
  if (self.quests)
  {
    NSMutableArray *questsMutableArray = [NSMutableArray array];
    for (RPGQuest *quest in self.quests)
    {
      [questsMutableArray addObject:[quest dictionaryRepresentation]];
    }
    dictionaryRepresentation[kRPGQuestListResponseQuests] = questsMutableArray;
  }
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  NSInteger status = [aDictionary[kRPGQuestListResponseStatus] integerValue];
  NSArray *questsDictionaryArray = aDictionary[kRPGQuestListResponseQuests];
  NSMutableArray *quests  =[NSMutableArray array];
  
  for (NSDictionary *questDictionary in questsDictionaryArray)
  {
    RPGQuest *quest = [[[RPGQuest alloc] initWithDictionaryRepresentation:questDictionary] autorelease];
    [quests addObject:quest];
  }
  return [self initWithStatus:status quests:quests];
}

@end
