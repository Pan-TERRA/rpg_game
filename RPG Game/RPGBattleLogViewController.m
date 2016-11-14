//
//  RPGBattleLogViewController.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleLogViewController.h"
  // API
#import "RPGBattleManager.h"
  // Entities
#import "RPGBattle.h"
#import "RPGBattleLog.h"
#import "RPGPlayer.h"
#import "RPGBattleAction.h"
#import "RPGSkillRepresentation.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"

static int sRPGBattleLogViewControllerBattleBattleLogAction;
NSString * const kRPGLogTemplatesFile = @"RPGLogTemplates.txt";

@interface RPGBattleLogViewController ()

@property (assign, nonatomic, readwrite) RPGBattleManager *battleManager;
@property (retain, nonatomic, readwrite) NSArray<NSString *> *templates;

@end

@implementation RPGBattleLogViewController

#pragma mark - Init

- (instancetype)initWithBattleManager:(RPGBattleManager *)aBattleManager
{
  self = [super init];
  
  if (self != nil)
  {
    NSString *logTemplatesFile = [[NSBundle mainBundle] pathForResource:kRPGLogTemplatesFile
                                                                 ofType:nil];
    NSString *templatesString = [NSString stringWithContentsOfFile:logTemplatesFile
                                                          encoding:NSUTF8StringEncoding
                                                             error:nil];
    _templates = [[templatesString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] retain];
    _battleManager = aBattleManager;
    [_battleManager addObserver:self
                     forKeyPath:@"battle.battleLog.actions"
                        options:(NSKeyValueObservingOptionNew)
                        context:&sRPGBattleLogViewControllerBattleBattleLogAction];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_battleManager removeObserver:self
                      forKeyPath:@"battle.battleLog.actions"
                         context:&sRPGBattleLogViewControllerBattleBattleLogAction];
  [_templates release];
  
  [super dealloc];
}

#pragma mark - Notifications

- (void)observeValueForKeyPath:(NSString *)aKeyPath
                      ofObject:(id)anObject
                        change:(NSDictionary<NSString *, id> *)aChange
                       context:(void *)aContext
{
  if (aContext == &sRPGBattleLogViewControllerBattleBattleLogAction)
  {
    if ([aChange[NSKeyValueChangeKindKey] unsignedIntegerValue] == NSKeyValueChangeInsertion)
    {
      NSIndexSet *newObjectIndices = aChange[NSKeyValueChangeIndexesKey];
      [self addMessageWithAction:self.battleManager.battle.battleLog.actions[newObjectIndices.firstIndex]];
    }
  }
  else
  {
    [super observeValueForKeyPath:aKeyPath
                         ofObject:anObject
                           change:aChange
                          context:aContext];
  }
}

#pragma mark - Actions

- (void)addMessageWithAction:(RPGBattleAction *)anAction
{
    // TODO: remove long-line invocations
  NSString *playerName = self.battleManager.battle.player.name;
  NSString *opponentName = self.battleManager.battle.opponent.name;
  
  BOOL myTurn = anAction.myTurn;
  NSString *attackerName = (myTurn ? playerName : opponentName);
  NSString *defenderName = (myTurn ? opponentName : playerName);
  
    // maybe better make class methods for RPGSkillRepresentation?
  RPGSkillRepresentation *skill = [[[RPGSkillRepresentation alloc] initWithSkillID:anAction.skillID] autorelease];
  NSString *skillName = skill.name;
  
  NSUInteger randomIndex = arc4random() % self.templates.count;
  NSString *formatString = [NSString stringWithFormat:@"%@\n", self.templates[randomIndex]];
  NSString *message = [NSString stringWithFormat:formatString, attackerName, defenderName, skillName, (long)anAction.damage];
  
  UITextView *textView = (UITextView *)self.view;
  [textView.textStorage appendAttributedString:[[[NSAttributedString alloc] initWithString:message] autorelease]];
  [self scrollViewToBottom];
}

- (void)scrollViewToBottom
{
  UITextView *textView = (UITextView *)self.view;
  if (textView.text.length > 0)
  {
    NSRange bottom = NSMakeRange(textView.text.length - 1, 1);
    [textView scrollRangeToVisible:bottom];
  }
}

@end
