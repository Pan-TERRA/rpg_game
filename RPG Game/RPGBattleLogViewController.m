//
//  RPGBattleLogViewController.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleLogViewController.h"
  // Controllers
#import "RPGBattleController.h"
  // Entities
#import "RPGBattle.h"
#import "RPGBattleLog.h"
#import "RPGPlayer.h"
#import "RPGBattleAction.h"
#import "RPGSkillRepresentation.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"
#import "RPGSFXEngine.h"

static int sRPGBattleLogViewControllerBattleBattleLogAction;
NSString * const kRPGLogTemplatesFile = @"RPGLogTemplates.txt";

@interface RPGBattleLogViewController ()

@property (retain, nonatomic, readwrite) RPGBattleController *battleController;
@property (retain, nonatomic, readwrite) NSArray<NSString *> *templates;

@end

@implementation RPGBattleLogViewController

#pragma mark - Init

- (instancetype)initWithBattleController:(RPGBattleController *)aBattleController
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
    _battleController = [aBattleController retain];
    [_battleController addObserver:self
                        forKeyPath:@"battle.battleLog.actions"
                           options:(NSKeyValueObservingOptionNew)
                           context:&sRPGBattleLogViewControllerBattleBattleLogAction];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_battleController removeObserver:self
                         forKeyPath:@"battle.battleLog.actions"
                            context:&sRPGBattleLogViewControllerBattleBattleLogAction];
  [_battleController release];
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
      [self addMessageWithAction:self.battleController.battle.battleLog.actions[newObjectIndices.firstIndex]];
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

/**
 *  Builds battle log message. Plays sound.
 *
 *  @param anAction An action.
 */
- (void)addMessageWithAction:(RPGBattleAction *)anAction
{
  NSInteger skillID = anAction.skillID;
  RPGSkillRepresentation *skill = [[[RPGSkillRepresentation alloc] initWithSkillID:skillID] autorelease];
  NSString *skillName = skill.name;
  BOOL myTurn = anAction.myTurn;
  
  NSString *playerNickName = self.battleController.playerNickName;
  NSString *opponentNickName = self.battleController.opponentNickName;
  
  NSString *attackerNickName = (myTurn ? playerNickName : opponentNickName);
  NSString *defenderNickName = (myTurn ? opponentNickName : playerNickName);
  
  NSUInteger randomIndex = arc4random() % self.templates.count;
  NSString *formatString = [NSString stringWithFormat:@"%@\n", self.templates[randomIndex]];
  NSString *message = [NSString stringWithFormat:formatString,
                       attackerNickName,
                       defenderNickName,
                       skillName,
                       (long)anAction.damage];
  
  UITextView *textView = (UITextView *)self.view;
  [textView.textStorage appendAttributedString:[[[NSAttributedString alloc] initWithString:message] autorelease]];
  
  if (skillID != 0)
  {
    [[RPGSFXEngine sharedSFXEngine] playSFXWithSpellID:skillID];
  }
  
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
