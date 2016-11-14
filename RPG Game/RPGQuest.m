//
//  RPGQuest.m
//  RPG Game
//
//  Created by Максим Шульга on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuest.h"
#import "RPGQuestReward.h"

NSString * const kRPGQuestID = @"quest_id";
NSString * const kRPGQuestName = @"name";
NSString * const kRPGQuestDescription = @"description";
NSString * const kRPGQuestState = @"state";
NSString * const kRPGQuestReward = @"reward";
NSString * const kRPGQuestProofImageStringURL = @"prove_image";

@interface RPGQuest()

@property (nonatomic, assign, readwrite) NSUInteger questID;
@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, copy, readwrite) NSString *questDescription;
@property (nonatomic, assign, readwrite) RPGQuestState state;
@property (nonatomic, retain, readwrite) RPGQuestReward *reward;
@property (nonatomic, copy, readwrite) NSString *proofImageStringURL;

@end

@implementation RPGQuest

#pragma mark - Init

- (instancetype)initWithID:(NSUInteger)aQuestID
                      name:(NSString *)aName
               description:(NSString *)aQuestDescription
                     state:(NSUInteger)aState
                    reward:(RPGQuestReward *)aReward
       proofImageStringURL:(NSString *)aStringURL
{
  self = [super init];
  
  if (self != nil)
  {
    _questID = aQuestID;
    _name = [aName copy];
    _questDescription = [aQuestDescription copy];
    _state = aState;
    _reward = [aReward retain];
    _proofImageStringURL = [aStringURL copy];
  }
  
  return self;
}

+ (instancetype)questWithID:(NSUInteger)aQuestID
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
  return [self initWithID:0 name:nil description:nil state:0 reward:nil proofImageStringURL:nil];
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
  
  return [self initWithID:questID
                     name:name
              description:questDescription
                    state:state
                   reward:reward
      proofImageStringURL:proofImageStringURL];
}

@end
