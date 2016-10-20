//
//  RPGQuest.m
//  RPG Game
//
//  Created by Максим Шульга on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuest.h"

@interface RPGQuest()

@property (nonatomic, assign, readwrite) NSUInteger questID;
@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, copy, readwrite) NSString *questDescription;
@property (nonatomic, assign, readwrite) RPGQuestState state;
@property (nonatomic, retain, readwrite) RPGQuestReward *reward;

@end

@implementation RPGQuest

#pragma mark - Init

- (instancetype)initWithID:(NSUInteger)aQuestID
                      name:(NSString *)aName
               description:(NSString *)aQuestDescription
                     state:(NSUInteger)aState
                    reward:(RPGQuestReward *)aReward
{
  self = [super init];
  
  if (self != nil)
  {
    _questID = aQuestID;
    _name = [aName copy];
    _questDescription = [aQuestDescription copy];
    _state = aState;
    _reward = [aReward retain];
  }
  
  return self;
}

+ (instancetype)questWithID:(NSUInteger)aQuestID
                       name:(NSString *)aName
                description:(NSString *)aQuestDescription
                      state:(NSUInteger)aState
                     reward:(RPGQuestReward *)aReward
{
  return [[[self alloc] initWithID:aQuestID
                              name:aName
                       description:aQuestDescription
                             state:aState
                            reward:aReward] autorelease];
}

- (instancetype)init
{
  return [self initWithID:0 name:nil description:nil state:0 reward:nil];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_name release];
  [_questDescription release];
  [_reward release];
  
  [super dealloc];
}

@end
