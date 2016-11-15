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

static NSString * const sRPGSkillBarViewControllerKeyPathToMyTurn = @"battleController.battle.currentTurn";

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
    [self addObserver:self
           forKeyPath:sRPGSkillBarViewControllerKeyPathToMyTurn
              options:NSKeyValueObservingOptionNew
              context:nil];
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
  [self removeObserver:self forKeyPath:sRPGSkillBarViewControllerKeyPathToMyTurn];
  [_skillRepresentations release];
  [super dealloc];
}

#pragma mark - Skill Action

- (IBAction)skillAction:(UIButton *)aSender
{
  if (self.battleController.isMyTurn && (aSender.tag <= self.battleController.skillsCount))
  {
    [self.battleController sendSkillActionRequestWithTag:aSender.tag];
    [self setButtonsEnable:NO];
  }
}

- (IBAction)skillButtonLongPress:(UILongPressGestureRecognizer *)aSender
{
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

- (void)setButtonsEnable:(BOOL)isEnabled
{
  for (NSInteger i = 1; i <= self.battleController.skillsCount ; i++)
  {
    UIButton *skillButton = (UIButton *)[self.view viewWithTag:i];
    skillButton.enabled = isEnabled;
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

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
  if ([keyPath isEqualToString:sRPGSkillBarViewControllerKeyPathToMyTurn])
  {
    if (self.battleController.isMyTurn)
    {
      [self setButtonsEnable:YES];
    }
  }
  else
  {
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
  }
}
@end
