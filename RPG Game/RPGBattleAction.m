//
//  RPGBattleAction.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleAction.h"

@interface RPGBattleAction ()

@property (assign, nonatomic, readwrite, getter=isMyTurn) BOOL myTurn;
@property (assign, nonatomic, readwrite) NSInteger skillID;
@property (assign, nonatomic, readwrite) NSInteger damage;

@end

@implementation RPGBattleAction

#pragma mark - Init

- (instancetype)initWithMyTurn:(BOOL)aMyTurn skillID:(NSInteger)aSkillID damage:(NSInteger)aDamage
{
  self = [super init];
  
  if (self != nil)
  {
    if (aSkillID < 0)
    {
      [self release];
      self = nil;
    }
    else
    {
      _myTurn = aMyTurn;
      _skillID = aSkillID;
      _damage = aDamage;
    }
  }
  
  return self;
}

@end
