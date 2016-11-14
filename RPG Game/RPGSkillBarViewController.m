//
//  RPGSkillBarViewController.m
//  RPG Game
//
//  Created by Владислав Крут on 11/9/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillBarViewController.h"
#import "RPGBattleManager.h"
#import "RPGBattle.h"
#import "RPGSkillRepresentation.h"
#import "RPGSkillDescriptionViewController.h"

#import "RPGBattleViewController.h"

//static NSString * const sRPGSkillKeyPathToBattle = @"battleManager.battle.player";

@interface RPGSkillBarViewController ()

@property (nonatomic, retain, readwrite) NSMutableArray<RPGSkillRepresentation *> *skillRepresentations;

@end

@implementation RPGSkillBarViewController

#pragma mark - Init

- (instancetype)initWithBattleManager:(RPGBattleManager *)aBattleManager
{
  self = [self init];
  if (self != nil)
  {
    _battleManager = aBattleManager;
    _skillRepresentations = [NSMutableArray new];
  }
  return self;
}

- (instancetype)init
{
  return [super initWithNibName:@"RPGSkillBarViewController" bundle:nil];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_skillRepresentations release];
  [super dealloc];
}

#pragma mark - Skill Action

- (IBAction)skillAction:(UIButton *)aSender
{
  NSArray *skills = self.battleManager.battle.player.skills;
  
  //button's tags from 1 to 7 (not 0..6, becouse 0 - default value)
  NSInteger index = aSender.tag - 1;
  
  // array range check
  if (index < skills.count && index >= 0)
  {
    [self.battleManager sendSkillActionRequestWithID:[skills[index] integerValue]];
  }
}
- (IBAction)skillButtonLongPress:(UILongPressGestureRecognizer *)aSender
{
  NSLog(@"State of long press gesture: %ld", (long)aSender.state);
  if (aSender.state == UIGestureRecognizerStateBegan)
  {
    //button's tags from 1 to 7 (not 0..6, becouse 0 - default value)
    NSInteger index = aSender.view.tag - 1;
    RPGSkillRepresentation *skill = self.skillRepresentations[index];
    RPGSkillDescriptionViewController *viewController = [RPGSkillDescriptionViewController viewControllerWithSkillRepresentation:skill];
    
    CGRect oldSkillViewRect = viewController.view.frame;
    CGRect superViewRect = self.parentViewController.view.frame;
    CGRect newSkillViewRect = CGRectMake((superViewRect.size.width - oldSkillViewRect.size.width) / 2,
                                         (superViewRect.size.height - oldSkillViewRect.size.height) / 2,
                                         oldSkillViewRect.size.width,
                                         oldSkillViewRect.size.height);
    UIView *skillView = viewController.view;
    skillView.frame = newSkillViewRect;
    
    RPGBattleViewController *parent = (RPGBattleViewController *)self.parentViewController;
    [parent showTooltipWithView:skillView];
  }
}

#pragma mark - UIViewController
- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

#pragma mark - RPGBattleObserver
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
  //TODO: remove hardcode
  if ([keyPath isEqualToString:@"battleManager.battle.player"])
  {
    if (self.battleManager.battle.player != nil)
    {
      //load skillRepresentations
      for (NSNumber *skillID in self.battleManager.battle.player.skills)
      {
        NSInteger integerSkillID = [skillID integerValue];
        RPGSkillRepresentation *representation = [RPGSkillRepresentation skillrepresentationWithSkillID:integerSkillID];
        [self.skillRepresentations addObject:representation];
      }
      
      //update view with button's images
      for (NSUInteger i = 0; i < 7; i++)
      {
        //button's tags from 1 to 7 (not 0..6, becouse 0 - default value)
        UIButton *skillButton = (UIButton *)[self.view viewWithTag:(i + 1)];
        
        //check array bounds
        RPGSkillRepresentation *representation = nil;
        if (i < self.skillRepresentations.count)
        {
          representation = self.skillRepresentations[i];
        }
        
        UIImage *backgroundImage = nil;
        //setting image
        if (representation != nil)
        {
          skillButton.enabled = true;
          backgroundImage = [UIImage imageNamed:representation.imageName];
          [skillButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
        }
        else
        {
          skillButton.enabled = false;
          //TODO: remove hardcode
          backgroundImage = [UIImage imageNamed:@"battle_empty_icon_lock"];
          [skillButton setBackgroundImage:backgroundImage forState:UIControlStateDisabled];
        }
      }
    }
  }
  else
  {
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
  }
  
}

@end
