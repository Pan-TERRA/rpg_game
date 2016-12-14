//
//  RPGQuest.m
//  RPG Game
//
//  Created by Максим Шульга on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuest.h"
#import "RPGQuestReward.h"

NSString * const kRPGQuestType = @"type";
NSString * const kRPGQuestID = @"quest_id";
NSString * const kRPGQuestName = @"name";
NSString * const kRPGQuestDescription = @"description";
NSString * const kRPGQuestState = @"state";
NSString * const kRPGQuestReward = @"reward";
NSString * const kRPGQuestGetReward = @"got_reward";
NSString * const kRPGQuestProofImageStringURL1 = @"prove_image_1";

@interface RPGQuest()

@property (nonatomic, assign, readwrite) RPGQuestType questType;
@property (nonatomic, assign, readwrite) NSInteger questID;
@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, copy, readwrite) NSString *questDescription;
@property (nonatomic, assign, readwrite) RPGQuestState state;
@property (nonatomic, retain, readwrite) RPGQuestReward *reward;
@property (nonatomic, assign, readwrite, getter=hasGotReward) BOOL getReward;
@property (nonatomic, copy, readwrite) NSString *proofImageStringURL1;

@end

@implementation RPGQuest

#pragma mark - Init

- (instancetype)initWithType:(RPGQuestType)aType
                     questID:(NSInteger)aQuestID
                        name:(NSString *)aName
                 description:(NSString *)aQuestDescription
                       state:(RPGQuestState)aState
                      reward:(RPGQuestReward *)aReward
                   getReward:(BOOL)hasGotReward
        proofImageStringURL1:(NSString *)aStringURL1
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
      _questType = aType;
      _questID = aQuestID;
      _name = [aName copy];
      _questDescription = [aQuestDescription copy];
      _state = aState;
      _reward = [aReward retain];
      _getReward = hasGotReward;
      _proofImageStringURL1 = [aStringURL1 copy];
    }
  }
  
  return self;
}

+ (instancetype)questWithType:(RPGQuestType)aType
                      questID:(NSInteger)aQuestID
                         name:(NSString *)aName
                  description:(NSString *)aQuestDescription
                        state:(RPGQuestState)aState
                       reward:(RPGQuestReward *)aReward
                    getReward:(BOOL)hasGotReward
         proofImageStringURL1:(NSString *)aStringURL1
{
  return [[[self alloc] initWithType:aType
                             questID:aQuestID
                                name:aName
                         description:aQuestDescription
                               state:aState
                              reward:aReward
                           getReward:hasGotReward
                proofImageStringURL1:aStringURL1] autorelease];
}

- (instancetype)init
{
  return [self initWithType:0
                    questID:-1
                       name:nil
                description:nil
                      state:0
                     reward:nil
                  getReward:YES
       proofImageStringURL1:nil];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_name release];
  [_questDescription release];
  [_reward release];
  [_proofImageStringURL1 release];
  
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
  dictionaryRepresentation[kRPGQuestGetReward] = @(self.hasGotReward);
  if (self.proofImageStringURL1)
  {
    dictionaryRepresentation[kRPGQuestProofImageStringURL1] = self.proofImageStringURL1;
  }
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  RPGQuestReward *reward = [[[RPGQuestReward alloc] initWithDictionaryRepresentation:aDictionary[kRPGQuestReward]] autorelease];
  
  return [self initWithType:[aDictionary[kRPGQuestType] integerValue]
                    questID:[aDictionary[kRPGQuestID] integerValue]
                       name:aDictionary[kRPGQuestName]
                description:aDictionary[kRPGQuestDescription]
                      state:[aDictionary[kRPGQuestState] integerValue]
                     reward:reward
                  getReward:[aDictionary[kRPGQuestGetReward] boolValue]
       proofImageStringURL1:aDictionary[kRPGQuestProofImageStringURL1]];
}

@end
