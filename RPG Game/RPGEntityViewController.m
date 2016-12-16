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
#import "RPGSkillEffectDescriptionViewController.h"
  // Views
#import "RPGSkillsEffectsCollectionViewCell.h"
  // Entities
#import "RPGPlayer.h"
#import "RPGSkillEffectRepresentation.h"
#import "RPGSkillEffect.h"
  // Misc
#import "UIViewController+RPGChildViewController.h"
  // Constants
#import "RPGNibNames.h"

static CGFloat const kRPGEntityViewControllerViewCornerRadiusMultiplier = 0.5;

@interface RPGEntityViewController ()

@property (nonatomic, assign, readwrite) IBOutlet UILabel *entityNickName;
@property (nonatomic, assign, readwrite) IBOutlet RPGProgressBarView *entityHPBar;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *entityHPLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIView *entityLevelView;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *entityLevelLabel;

@property (nonatomic, retain, readwrite) RPGSkillsEffectsCollectionViewController *skillsEffectsCollectionViewController;
@property (nonatomic, assign, readwrite) IBOutlet UICollectionView *skillsEffectsCollectionView;

@end

@implementation RPGEntityViewController

#pragma mark - Init

- (instancetype)initWithEntity:(RPGEntity *)anEntity
                         align:(RPGAlign)anAlign
{
  NSString *NIBName = nil;
  
  if (anAlign == kRPGAlignLeft)
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

- (instancetype)initWithAlign:(RPGAlign)anAlign
{
  return [self initWithEntity:nil
                        align:anAlign];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
{
  return [self initWithEntity:nil
                        align:kRPGAlignLeft];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
  return [self initWithEntity:nil
                        align:kRPGAlignLeft];
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

  RPGAlign align = self.entityHPBar.align;
  self.skillsEffectsCollectionViewController = [RPGSkillsEffectsCollectionViewController
                                                skillEffectsControllerWithCollectionView:self.skillsEffectsCollectionView
                                                skillsEffects:self.entity.skillsEffects
                                                align:align];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

#pragma mark - View Update

- (void)updateView
{
  RPGEntity *entity = self.entity;
  
  if (entity != nil)
  {
    NSInteger entityHP = entity.HP;
    NSInteger entityMaxHP = entity.maxHP;
    entityHP = (entityHP <= entityMaxHP) ? entityHP : entityMaxHP;
    self.entityNickName.text = entity.name;
    self.entityHPBar.progress = ((float)entityHP / entityMaxHP);
    self.entityHPLabel.text = [NSString stringWithFormat:@"%ld/%ld", (long)entityHP, (long)entityMaxHP];
    self.entityLevelLabel.text = [NSString stringWithFormat:@"%ld", (long)entity.level];
    self.skillsEffectsCollectionViewController.skillsEffects = entity.skillsEffects;
    
    [self.skillsEffectsCollectionView reloadData];
  }
}

#pragma mark - IBActions

- (IBAction)handleTapGesture:(UITapGestureRecognizer *)aRecognizer
{
  UICollectionView *collectionView = self.skillsEffectsCollectionView;
  CGPoint point = [aRecognizer locationInView:collectionView];
  NSIndexPath *path = [self.skillsEffectsCollectionView indexPathForItemAtPoint:point];
  RPGSkillsEffectsCollectionViewCell *cell = (RPGSkillsEffectsCollectionViewCell *)[collectionView cellForItemAtIndexPath:path];
  
  if (cell != nil)
  {
    RPGSkillEffectDescriptionViewController *skillEffectDescriptionViewController = [[[RPGSkillEffectDescriptionViewController alloc] init] autorelease];
    
    RPGSkillEffectRepresentation *skillEffectRepresentation = [RPGSkillEffectRepresentation skillEffectRepresentationWithSkillEffectID:cell.skillEffectID];
    
    UIViewController *parentViewController = self.parentViewController;
    [parentViewController addChildViewController:skillEffectDescriptionViewController
                                           frame:parentViewController.view.frame];
    
    [skillEffectDescriptionViewController setViewContent:skillEffectRepresentation];
  }
}

@end
