  //
  //  RPGSkillBarViewController.m
  //  RPG Game
  //
  //  Created by Владислав Крут on 11/9/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGSkillBarViewController.h"
// Frameworks
#import <QuartzCore/QuartzCore.h>
  // Entities
#import "RPGBattle.h"
#import "RPGSkill.h"
#import "RPGSkillRepresentation.h"
  // Controllers
#import "RPGBattleController+RPGBattlePresentationController.h"
#import "UIViewController+RPGChildViewController.h"
#import "RPGBattleViewController.h"
#import "RPGSkillDescriptionViewController.h"
  // Constants
#import "RPGNibNames.h"

// Constants

static NSInteger kRPGSkillBarViewControllerSkillButtonCornerRadius = 15;

@interface RPGSkillBarViewController ()

@property (nonatomic, retain, readwrite) NSMutableArray<RPGSkillRepresentation *> *skillRepresentations;

@end

@implementation RPGSkillBarViewController

#pragma mark - Init

- (instancetype)initWithBattleController:(RPGBattleController *)aBattleController
{
  self = [self init];
  
  if (self != nil)
  {
    _battleController = aBattleController;
  }
  
  return self;
}

- (instancetype)init
{
  return [super initWithNibName:kRPGSkillBarViewControllerNIBName bundle:nil];
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
  NSArray<RPGSkill *> *skills = self.battleController.skills;
  NSInteger index = aSender.tag - 1;
  NSInteger skillID = skills[index].skillID;
  
  [self.battleController sendSkillActionRequestWithSkillID:skillID];
  [self lockSkillBar];
}

- (IBAction)skillButtonLongPress:(UILongPressGestureRecognizer *)aSender
{
  if (aSender.state == UIGestureRecognizerStateBegan)
  {
    NSInteger index = aSender.view.tag - 1;
    RPGSkillRepresentation *skillRepresentation = self.skillRepresentations[index];
    RPGSkillDescriptionViewController *skillDescriptionViewController = [[[RPGSkillDescriptionViewController alloc] init] autorelease];
    
    UIViewController *parentViewController = self.parentViewController;
    [parentViewController addChildViewController:skillDescriptionViewController
                                           frame:parentViewController.view.frame];
    
    [skillDescriptionViewController setViewContent:skillRepresentation];
  }
}

#pragma mark - View State

- (void)lockSkillBar
{
  for (NSInteger i = 1; i <= self.battleController.skillsCount; i++)
  {
    ((UIButton *)[self.view viewWithTag:i]).enabled = NO;
  }
}

- (void)updateButtonsState
{
  NSArray<RPGSkill *> *skills = self.battleController.skills;
  
  for (NSInteger i = 0; i < skills.count; i++)
  {
    BOOL isSkillActive = (skills[i].cooldown == 0) ? YES : NO;
    ((UIButton *)[self.view viewWithTag:(i + 1)]).enabled = isSkillActive;
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

#pragma mark - Notifications

- (void)battleInitDidEndSetUp:(NSNotification *)aNotification
{
  self.skillRepresentations = [NSMutableArray new];
  
    //load skillRepresentations
  for (RPGSkill *skill in self.battleController.skills)
  {
    NSInteger skillID = skill.skillID;
    RPGSkillRepresentation *representation = [RPGSkillRepresentation skillrepresentationWithSkillID:skillID];
    [self.skillRepresentations addObject:representation];
  }
  
    //update view with button's images
  for (NSUInteger i = 0; i < 5; i++)
  {
    RPGSkillRepresentation *representation = nil;
    UIImage *backgroundImage = nil;
    UIButton *skillButton = (UIButton *)[self.view viewWithTag:(i + 1)];
    
      //check array bounds
    if (i < self.skillRepresentations.count)
    {
      representation = self.skillRepresentations[i];
    }
    
      //setting image
    if (representation != nil)
    {
      skillButton.enabled = YES;
      if (representation.imageName.length != 0)
      {
        backgroundImage = [UIImage imageNamed:representation.imageName];
        [skillButton setImage:[UIImage imageNamed:@"battle_empty_icon_inactive"]
                     forState:UIControlStateNormal];
        skillButton.layer.cornerRadius = kRPGSkillBarViewControllerSkillButtonCornerRadius;
        skillButton.layer.masksToBounds = YES;
      }
      else
      {
          // default image for skills/items with no image
        backgroundImage = [UIImage imageNamed:@"battle_empty_icon_unset"];
      }
      
      [skillButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    }
    else
    {
      skillButton.enabled = NO;
      backgroundImage = [UIImage imageNamed:@"battle_empty_icon_lock"];
      [skillButton setBackgroundImage:backgroundImage forState:UIControlStateDisabled];
    }
  }
  
  [self lockSkillBar];
}

@end
