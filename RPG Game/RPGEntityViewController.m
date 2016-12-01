  //
  //  RPGEntityViewController.m
  //  RPG Game
  //
  //  Created by Иван Дзюбенко on 12/1/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGEntityViewController.h"
  // Controllers
#import "RPGBattleController+RPGBattlePresentationController.h"
  // Entities
#import "RPGPlayer.h"
  // Constants
#import "RPGNibNames.h"

static int sEntityViewContollerBattleEntityContext;

@interface RPGEntityViewController ()

@property (nonatomic, assign, readwrite) IBOutlet UILabel *entityNickName;
@property (nonatomic, assign, readwrite) IBOutlet RPGProgressBarView *entityHPBar;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *entityHPLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIView *entityLevelView;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *entityLevelLabel;

@end

@implementation RPGEntityViewController

#pragma mark - Init

- (instancetype)initWithEntity:(RPGEntity *)anEntity
                                   align:(RPGProgressBarAlign)anAlignFlag
{
  NSString *NIBName = nil;
  
  if (anAlignFlag == kRPGProgressBarLeftAlign)
  {
    NIBName = kRPGEntityViewLeftNIBName;
  }
  else
  {
    NIBName = kRPGEntityViewRightNIBName;
  }
  
  self = [super initWithNibName:NIBName bundle:nil];
  
  if (self != nil)
  {
    _entity = anEntity;
  }
  
  return self;
}

- (instancetype)initWithAlign:(RPGProgressBarAlign)anAlignFlag
{
  return [self initWithEntity:nil align:anAlignFlag];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  return [self initWithEntity:nil align:kRPGProgressBarLeftAlign];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
  return [self initWithEntity:nil align:kRPGProgressBarLeftAlign];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
    //  self.entityLevelView.layer.cornerRadius = kRPGBattleViewControllerLevelViewCornerRadius;
    //  self.entityLevelView.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Update

- (void)updateView
{
  if (self.entity != nil)
  {
    NSInteger entityHP = self.entity.HP;
    NSInteger entityMaxHP = self.entity.maxHP;
    entityHP = (entityHP <= entityMaxHP) ? entityHP : entityMaxHP;
    self.entityNickName.text = self.entity.name;
    self.entityHPBar.progress = ((float)entityHP / entityMaxHP);
    self.entityHPLabel.text = [NSString stringWithFormat:@"%ld/%ld", (long)entityHP, (long)entityMaxHP];
    self.entityLevelLabel.text = [NSString stringWithFormat:@"%ld", (long)self.entity.level];
  }
}

@end
