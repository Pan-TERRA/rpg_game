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
#import "RPGBattleController.h"
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
  if (self.battleController.isMyTurn && (aSender.tag <= self.battleController.skillsCount))
  {
    [self.battleController sendSkillActionRequestWithTag:aSender.tag];
  }
}

- (IBAction)skillButtonLongPress:(UILongPressGestureRecognizer *)aSender
{
  NSLog(@"State of long press gesture: %ld", (long)aSender.state);
  
  if (aSender.state == UIGestureRecognizerStateBegan)
  {
    NSInteger index = aSender.view.tag - 1;
    RPGSkillRepresentation *skillRepresentation = self.skillRepresentations[index];
    RPGSkillDescriptionViewController *viewController = [RPGSkillDescriptionViewController viewControllerWithSkillRepresentation:skillRepresentation];
    
    CGFloat initialSkillViewRectWidth = viewController.view.frame.size.width;
    CGFloat initialSkillViewRectHeight = viewController.view.frame.size.height;
    CGSize battleViewControllerFrameSize = self.parentViewController.view.frame.size;
    
    CGRect centeredSkillViewRect = CGRectMake((battleViewControllerFrameSize.width - initialSkillViewRectWidth) / 2,
                                              (battleViewControllerFrameSize.height - initialSkillViewRectHeight) / 2,
                                              initialSkillViewRectWidth,
                                              initialSkillViewRectHeight);
    
    viewController.view.frame = centeredSkillViewRect;
    
    [(RPGBattleViewController *)self.parentViewController showTooltipWithView:viewController.view];
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
  for (NSNumber *skillID in self.battleController.skillsID)
  {
    RPGSkillRepresentation *representation = [RPGSkillRepresentation skillrepresentationWithSkillID:[skillID integerValue]];
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

@end
