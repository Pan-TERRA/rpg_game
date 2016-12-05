//
//  RPGSkillsEffectsViewController.m
//  RPG Game
//
//  Created by Максим Шульга on 12/5/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillsEffectsViewController.h"
  // Controller
#import "RPGBattleController.h"
  // Entities
#import "RPGBattle.h"
#import "RPGSkillEffect.h"
  // Views
#import "RPGCharacterBagCollectionViewCell.h"
  // Constants
#import "RPGNibNames.h"

static int sRPGSkillsEffectsViewControllerSkillsEffects;
static NSInteger kRPGSkillsEffectsViewControllerCollectionSize = 6;
static NSInteger kRPGSkillsEffectsViewControllerSkillEffectCellCornerRadius = 20;

@interface RPGSkillsEffectsViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, retain, readwrite) RPGBattleController *battleController;
@property (nonatomic, assign, readwrite) IBOutlet UICollectionView *skillsEffectsCollectionView;

@end

@implementation RPGSkillsEffectsViewController

- (instancetype)init
{
  return [super initWithNibName:kRPGSkillsEffectsViewControllerNIBName bundle:nil];
}

- (instancetype)initWithBattleController:(RPGBattleController *)aBattleController
{
  self = [super initWithNibName:kRPGSkillsEffectsViewControllerNIBName bundle:nil];
  
  if (self != nil)
  {
    _battleController = [aBattleController retain];
    [_battleController addObserver:self
                        forKeyPath:@"battle.playerSkillsEffects"
                           options:(NSKeyValueObservingOptionNew)
                           context:&sRPGSkillsEffectsViewControllerSkillsEffects];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_battleController removeObserver:self
                         forKeyPath:@"battle.playerSkillsEffects"
                            context:&sRPGSkillsEffectsViewControllerSkillsEffects];
  [_battleController release];
  
  [super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UINib *cellNIB = [UINib nibWithNibName:kRPGCharacterBagCollectionViewCellNIBName bundle:nil];
  [self.skillsEffectsCollectionView registerNib:cellNIB forCellWithReuseIdentifier:kRPGCharacterBagCollectionViewCellNIBName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return kRPGSkillsEffectsViewControllerCollectionSize;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)aCollectionView cellForItemAtIndexPath:(NSIndexPath *)anIndexPath
{
  RPGCharacterBagCollectionViewCell *cell = [aCollectionView dequeueReusableCellWithReuseIdentifier:kRPGCharacterBagCollectionViewCellNIBName
                                                                                       forIndexPath:anIndexPath];
  
  NSInteger index = anIndexPath.row;
  NSArray *skillsEffects = self.battleController.battle.playerSkillsEffects;
  if (index < skillsEffects.count)
  {
    RPGSkillEffect *skillEffect = skillsEffects[index];
    
    cell.image = [UIImage imageNamed:@"battle_empty_icon_inactive"];
    cell.backgroundImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"skill_effect_%ld", (long)skillEffect.skillEffectID]];
    cell.backgroundImageView.layer.cornerRadius = kRPGSkillsEffectsViewControllerSkillEffectCellCornerRadius;
    cell.backgroundImageView.layer.masksToBounds = YES;
  }
  else
  {
    [cell setImage:[UIImage imageNamed:@"battle_empty_icon_unset"]];
    cell.backgroundImageView.image = nil;
  }
  
  return cell;
}

#pragma mark - Notifications

- (void)observeValueForKeyPath:(NSString *)aKeyPath
                      ofObject:(id)anObject
                        change:(NSDictionary<NSString *, id> *)aChange
                       context:(void *)aContext
{
  if (aContext == &sRPGSkillsEffectsViewControllerSkillsEffects)
  {
    if ([aChange[NSKeyValueChangeKindKey] unsignedIntegerValue] == NSKeyValueChangeSetting)
    {
      [self.skillsEffectsCollectionView reloadData];
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

@end
