//
//  RPGQuest.m
//  RPG Game
//
//  Created by Максим Шульга on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuest.h"
#import "RPGQuestReward.h"

static NSString * const kRPGQuestID = @"quest_id";
static NSString * const kRPGQuestName = @"name";
static NSString * const kRPGQuestDescription = @"description";
static NSString * const kRPGQuestState = @"state";
static NSString * const kRPGQuestReward = @"reward";
static NSString * const kRPGQuestProofImageStringURL = @"prove_image";

@interface RPGQuest()

@property (nonatomic, assign, readwrite) NSInteger questID;
@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, copy, readwrite) NSString *questDescription;
@property (nonatomic, assign, readwrite) RPGQuestState state;
@property (nonatomic, retain, readwrite) RPGQuestReward *reward;
@property (nonatomic, copy, readwrite) NSString *proofImageStringURL;

@end

@implementation RPGQuest

#pragma mark - Init

- (instancetype)initWithID:(NSInteger)aQuestID
                      name:(NSString *)aName
               description:(NSString *)aQuestDescription
                     state:(NSUInteger)aState
                    reward:(RPGQuestReward *)aReward
       proofImageStringURL:(NSString *)aStringURL
{
  self = [super init];
  
  if (self != nil)
  {
    if (aQuestID < 1)
    {
      [self release];
      self = nil;
    }
    else
    {
      _questID = aQuestID;
      _name = [aName copy];
      _questDescription = [aQuestDescription copy];
      _state = aState;
      _reward = [aReward retain];
      _proofImageStringURL = [aStringURL copy];
    }
  }
  
  return self;
}

+ (instancetype)questWithID:(NSInteger)aQuestID
                       name:(NSString *)aName
                description:(NSString *)aQuestDescription
                      state:(NSUInteger)aState
                     reward:(RPGQuestReward *)aReward
        proofImageStringURL:(NSString *)aStringURL
{
  return [[[self alloc] initWithID:aQuestID
                              name:aName
                       description:aQuestDescription
                             state:aState
                            reward:aReward
               proofImageStringURL:aStringURL] autorelease];
}

- (instancetype)init
{
  return [self initWithID:-1
                     name:nil
              description:nil
                    state:0
                   reward:nil
      proofImageStringURL:nil];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_name release];
  [_questDescription release];
  [_reward release];
  [_proofImageStringURL release];
  
  [super dealloc];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGQuestID] = @(self.questID);
  if (self.name != nil)
  {
    dictionaryRepresentation[kRPGQuestName] = self.name;
  }
  if (self.questDescription != nil)
  {
    dictionaryRepresentation[kRPGQuestDescription] = self.questDescription;
  }
  dictionaryRepresentation[kRPGQuestState] = @(self.state);
  if (self.reward != nil)
  {
    dictionaryRepresentation[kRPGQuestReward] = [self.reward dictionaryRepresentation];
  }
  if (self.proofImageStringURL)
  {
    dictionaryRepresentation[kRPGQuestProofImageStringURL] = self.proofImageStringURL;
  }
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  RPGQuestReward *reward = [[[RPGQuestReward alloc] initWithDictionaryRepresentation:aDictionary[kRPGQuestReward]] autorelease];
  
  return [self initWithID:[aDictionary[kRPGQuestID] integerValue]
                     name:aDictionary[kRPGQuestName]
              description:aDictionary[kRPGQuestDescription]
                    state:[aDictionary[kRPGQuestState] integerValue]
                   reward:reward
      proofImageStringURL:aDictionary[kRPGQuestProofImageStringURL]];
}

@end
