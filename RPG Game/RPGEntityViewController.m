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
#import "RPGSkillsEffectsCollectionViewController.h"
  // Entities
#import "RPGPlayer.h"
  // Constants
#import "RPGNibNames.h"

static CGFloat const kRPGEntityViewControllerViewCornerRadiusMultiplier = 0.5;

@interface RPGEntityViewController ()

@property (nonatomic, assign, readwrite) IBOutlet UILabel *entityNickName;
@property (nonatomic, assign, readwrite) IBOutlet RPGProgressBarView *entityHPBar;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *entityHPLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIView *entityLevelView;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *entityLevelLabel;
@property (nonatomic, assign, readwrite) IBOutlet UICollectionView *skillsEffectsCollectionView;
@property (nonatomic, retain, readwrite) RPGSkillsEffectsCollectionViewController *skillsEffectsCollectionViewController;

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
    _skillsEffectsCollectionViewController = [[RPGSkillsEffectsCollectionViewController alloc] init];
  }
  
  return self;
}

- (instancetype)initWithAlign:(RPGProgressBarAlign)anAlignFlag
{
  return [self initWithEntity:nil
                        align:anAlignFlag];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
{
  return [self initWithEntity:nil
                        align:kRPGProgressBarLeftAlign];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
  return [self initWithEntity:nil
                        align:kRPGProgressBarLeftAlign];
}

#pragma marl - Dealloc

- (void)dealloc
{
  [_skillsEffectsCollectionViewController release];
  
  [super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.entityLevelView.layer.cornerRadius = self.entityLevelView.frame.size.height * kRPGEntityViewControllerViewCornerRadiusMultiplier;
  self.entityLevelView.layer.masksToBounds = YES;
  
  UINib *cellNIB = [UINib nibWithNibName:kRPGSkillsEffectsCollectionViewCellNIBName
                                  bundle:nil];
  [self.skillsEffectsCollectionView registerNib:cellNIB
                     forCellWithReuseIdentifier:kRPGSkillsEffectsCollectionViewCellNIBName];
  
  RPGSkillsEffectsCollectionViewAlign align = (self.entityHPBar.align == kRPGProgressBarLeftAlign) ? kRPGSkillsEffectsCollectionViewAlignLeft : kRPGSkillsEffectsCollectionViewAlignRight;
  self.skillsEffectsCollectionViewController = [[[RPGSkillsEffectsCollectionViewController alloc]
                                                 initWithCollectionView:self.skillsEffectsCollectionView
                                                 skillsEffects:self.entity.skillsEffects
                                                 align:align] autorelease];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
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
    self.skillsEffectsCollectionViewController.skillsEffects = self.entity.skillsEffects;
    [self.skillsEffectsCollectionView reloadData];
  }
}

@end
