//
//  RPGIncomingDuelQuestListResponse.m
//  RPG Game
//
//  Created by Максим Шульга on 12/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGIncomingDuelQuestListResponse.h"
  // Entities
#import "RPGIncomingDuelQuest.h"

@interface RPGIncomingDuelQuestListResponse ()

@property (nonatomic, retain, readwrite) NSArray<RPGIncomingDuelQuest *> *incomingQuests;

@end

@implementation RPGIncomingDuelQuestListResponse

#pragma mark - Init

- (instancetype)initWithStatus:(NSInteger)aStatus
                incomingQuests:(NSArray<RPGIncomingDuelQuest *> *)anIncomingQuests
{
  self = [super initWithStatus:aStatus
                        quests:[NSArray array]];
  
  if (self != nil)
  {
    if (anIncomingQuests == nil)
    {
      _incomingQuests = nil;
    }
    else
    {
      _incomingQuests = [anIncomingQuests retain];
    }
  }
  
  return self;
}

+ (instancetype)responseWithStatus:(NSInteger)aStatus
                    incomingQuests:(NSArray<RPGIncomingDuelQuest *> *)anIncomingQuests
{
  return [[[self alloc] initWithStatus:aStatus
                        incomingQuests:anIncomingQuests] autorelease];
}

- (instancetype)init
{
  return [self initWithStatus:-1
               incomingQuests:nil];
}

- (instancetype)initWithStatus:(RPGStatusCode)aStatus
                        quests:(NSArray<RPGQuest *> *)aQuests
{
  return [self initWithStatus:-1
               incomingQuests:nil];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_incomingQuests release];
  
  [super dealloc];
}

- (NSArray<RPGIncomingDuelQuest *> *)quests
{
  return self.incomingQuests;
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  dictionaryRepresentation[kRPGQuestListResponseStatus] = @(self.status);
  
  if (self.incomingQuests)
  {
    NSMutableArray *questsMutableArray = [NSMutableArray array];
    
    for (RPGIncomingDuelQuest *quest in self.incomingQuests)
    {
      [questsMutableArray addObject:[quest dictionaryRepresentation]];
    }
    
    dictionaryRepresentation[kRPGQuestListResponseQuests] = questsMutableArray;
  }
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  NSArray *questsDictionaryArray = aDictionary[kRPGQuestListResponseQuests];
  NSMutableArray *quests  =[NSMutableArray array];
  
  for (NSDictionary *questDictionary in questsDictionaryArray)
  {
    RPGIncomingDuelQuest *quest = [[[RPGIncomingDuelQuest alloc] initWithDictionaryRepresentation:questDictionary] autorelease];
    [quests addObject:quest];
  }
  
  return [self initWithStatus:[aDictionary[kRPGQuestListResponseStatus] integerValue]
               incomingQuests:quests];
}

@end
