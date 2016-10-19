//
//  RPGQuest.m
//  RPG Game
//
//  Created by Максим Шульга on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuest.h"

@interface RPGQuest()

@property (nonatomic, assign, readwrite) NSUInteger questId;
@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, copy, readwrite) NSString *questDescription;
@property (nonatomic, assign, readwrite) NSUInteger state;
@property (nonatomic, retain, readwrite) RPGQuestReward *reward;

@end

@implementation RPGQuest

#pragma mark - Init

- (instancetype)initWithId:(NSUInteger)questId
                      name:(NSString *)name
               description:(NSString *)questDescription
                     state:(NSUInteger)state
                    reward:(RPGQuestReward *)reward
{
  self = [super init];
  
  if (self != nil)
  {
    _questId = questId;
    _name = [name copy];
    _questDescription = [questDescription copy];
    _state = state;
    _reward = [reward retain];
  }
  
  return self;
}

+ (instancetype)questWithId:(NSUInteger)questId
                       name:(NSString *)name
                description:(NSString *)questDescription
                      state:(NSUInteger)state
                     reward:(RPGQuestReward *)reward
{
  return [[[self alloc] initWithId:questId name:name description:questDescription state:state reward:reward] autorelease];
}

- (instancetype)init
{
  return [self initWithId:0 name:nil description:nil state:0 reward:nil];
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