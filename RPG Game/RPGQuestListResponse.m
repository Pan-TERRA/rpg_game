//
//  RPGQuestListResponse.m
//  RPG Game
//
//  Created by Максим Шульга on 10/17/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestListResponse.h"

@interface RPGQuestListResponse ()

@property (nonatomic, assign, readwrite) NSInteger status;
@property (nonatomic, retain, readwrite) NSArray *quests;

@end

@implementation RPGQuestListResponse

#pragma mark - Init

- (instancetype)initWithStatus:(NSInteger)status
                        quests:(NSArray *)quests
{
  self = [super init];
  
  if (self != nil)
  {
    if (quests == nil)
    {
      [self release];
      self = nil;
    }
    else
    {
      _status = status;
      _quests = [quests retain];
    }
  }
  
  return self;
}

+ (instancetype)responseWithStatus:(NSInteger)status
                            quests:(NSArray *)quests
{
  return [[[self alloc] initWithStatus:status quests:quests] autorelease];
}

- (instancetype)init
{
  return [self initWithStatus:-1 quests:nil];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_quests release];
  [super dealloc];
}

@end