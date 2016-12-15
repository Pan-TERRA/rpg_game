//
//  RPGQuestListResponse.m
//  RPG Game
//
//  Created by Максим Шульга on 10/17/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestListResponse.h"
  // Entities
#import "RPGQuest.h"

static NSString * const kRPGQuestListResponseStatus = @"status";
static NSString * const kRPGQuestListResponseQuests = @"quests";

@interface RPGQuestListResponse ()

@property (nonatomic, assign, readwrite) RPGStatusCode status;
@property (nonatomic, retain, readwrite) NSArray<RPGQuest *> *quests;

@end

@implementation RPGQuestListResponse

#pragma mark - Init

- (instancetype)initWithStatus:(RPGStatusCode)aStatus
                        quests:(NSArray<RPGQuest *> *)aQuests
{
  self = [super init];
  
  if (self != nil)
  {
    if (aStatus == kRPGStatusCodeOK && aQuests == nil)
    {
      [self release];
      self = nil;
    }
    else if (aStatus != 0 && aQuests == nil)
    {
      _quests = nil;
    }
    else
    {
      _status = aStatus;
      _quests = [aQuests retain];
    }
  }
  
  return self;
}

+ (instancetype)responseWithStatus:(RPGStatusCode)aStatus
                            quests:(NSArray<RPGQuest *> *)aQuests
{
  return [[[self alloc] initWithStatus:aStatus
                                quests:aQuests] autorelease];
}

- (instancetype)init
{
  return [self initWithStatus:0
                       quests:nil];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_quests release];
  
  [super dealloc];
}

#pragma mark - RPGSerializable

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
  NSArray *questsDictionaryArray = aDictionary[kRPGQuestListResponseQuests];
  NSMutableArray *quests  =[NSMutableArray array];
  
  for (NSDictionary *questDictionary in questsDictionaryArray)
  {
    RPGQuest *quest = [[[RPGQuest alloc] initWithDictionaryRepresentation:questDictionary] autorelease];
    [quests addObject:quest];
  }
  
  return [self initWithStatus:[aDictionary[kRPGQuestListResponseStatus] integerValue]
                       quests:quests];
}

@end
