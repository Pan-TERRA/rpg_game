  //
  //  RPGSkillBarViewController.m
  //  RPG Game
  //
  //  Created by Владислав Крут on 11/9/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGSkillBarViewController.h"
  // Entities
#import "RPGBattle.h"
#import "RPGSkillRepresentation.h"
  // Controllers
#import "RPGBattleController+RPGBattlePresentationController.h"
#import "RPGBattleViewController.h"
#import "RPGSkillDescriptionViewController.h"

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
  NSInteger tag = aSender.tag;
  
  if (self.battleController.isMyTurn && (tag <= self.battleController.skillsCount))
  {
    NSArray *skills = self.battleController.skills;
    NSInteger index = tag - 1;
    // TODO: redo
    NSInteger skillID = [[[skills[index] allKeys] firstObject] integerValue];
    
    [self.battleController sendSkillActionRequestWithSkillID:skillID];
    [self disableButtons];
  }
}

- (IBAction)skillButtonLongPress:(UILongPressGestureRecognizer *)aSender
{
  if (aSender.state == UIGestureRecognizerStateBegan)
  {
    NSInteger index = aSender.view.tag - 1;
    RPGSkillRepresentation *skillRepresentation = self.skillRepresentations[index];
    RPGSkillDescriptionViewController *viewController = [RPGSkillDescriptionViewController viewControllerWithSkillRepresentation:skillRepresentation];
    
    UIViewController *parentViewController = self.parentViewController;
    [parentViewController addChildViewController:viewController];
    viewController.view.frame = parentViewController.view.frame;
    [parentViewController.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:parentViewController];
  }
}

#pragma mark - View State

- (void)disableButtons
{
  for (NSInteger i = 1; i <= self.battleController.skillsCount; i++)
  {
    ((UIButton *)[self.view viewWithTag:i]).enabled = NO;
  }
}

- (void)updateButtonsState
{
  NSArray *skills = self.battleController.skills;
  for (NSInteger i = 1; i <= skills.count; i++)
  {
    BOOL active = NO;
      // TODO: redo
    NSInteger cooldown = [[[skills[i - 1] allValues] firstObject] integerValue];
    if (cooldown == 0)
    {
      active = YES;
    }
    ((UIButton *)[self.view viewWithTag:i]).enabled = active;
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
    //load skillRepresentations
  for (NSDictionary *skillDictionary in self.battleController.skills)
  {
    NSInteger skillID = [[[skillDictionary allKeys] firstObject] integerValue];
    RPGSkillRepresentation *representation = [RPGSkillRepresentation skillrepresentationWithSkillID:skillID];
    [self.skillRepresentations addObject:representation];
  }
  
    //update view with button's images
  for (NSUInteger i = 0; i < 7; i++)
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
      backgroundImage = [UIImage imageNamed:representation.imageName];
      [skillButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    }
    else
    {
      skillButton.enabled = NO;
      backgroundImage = [UIImage imageNamed:@"battle_empty_icon_lock"];
      [skillButton setBackgroundImage:backgroundImage forState:UIControlStateDisabled];
    }
  }
}

@end
