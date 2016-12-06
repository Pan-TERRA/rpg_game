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
#import "RPGSkillsEffectsCollectionViewCell.h"
  // Constants
#import "RPGNibNames.h"

static int sRPGSkillsEffectsViewControllerSkillsEffects;
static NSUInteger const kRPGSkillsEffectsViewControllerCollectionSize = 6;
static NSUInteger const kRPGSkillsEffectsViewControllerNumberOfCellsInRow = 2;
static NSUInteger const kRPGSkillsEffectsViewControllerSkillEffectCellCornerRadius = 20;
static CGFloat const kRPGSkillsEffectsViewControllerSkillEffectDurationViewCornerRadiusMultiplier = 0.5;

@interface RPGSkillsEffectsViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, retain, readwrite) RPGBattleController *battleController;
@property (nonatomic, assign, readwrite) IBOutlet UICollectionView *skillsEffectsCollectionView;
@property (nonatomic, assign, readwrite) RPGPlayerType playerType;

@end

@implementation RPGSkillsEffectsViewController

#pragma mark - Init

- (instancetype)init
{
  return [super initWithNibName:kRPGSkillsEffectsViewControllerNIBName
                         bundle:nil];
}

- (instancetype)initWithBattleController:(RPGBattleController *)aBattleController
                              playerType:(RPGPlayerType)aPlayerType
{
  self = [super initWithNibName:kRPGSkillsEffectsViewControllerNIBName
                         bundle:nil];
  
  if (self != nil)
  {
    _battleController = [aBattleController retain];
    _playerType = kRPGPlayerTypeNull;
    [self setPlayerType:aPlayerType];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [self setPlayerType:kRPGPlayerTypeNull];
  [_battleController release];
  
  [super dealloc];
}

#pragma mark - Custom Setter

- (void)setPlayerType:(RPGPlayerType)playerType
{
  if (_playerType != kRPGPlayerTypeNull)
  {
    NSString *keyPathToRemoveObserver = [self keyPathForPlayerType:_playerType];
    [_battleController removeObserver:self
                           forKeyPath:keyPathToRemoveObserver
                              context:&sRPGSkillsEffectsViewControllerSkillsEffects];
  }
  _playerType = playerType;
  if (_playerType != kRPGPlayerTypeNull)
  {
    NSString *keyPathToAddObserver = [self keyPathForPlayerType:_playerType];
    [_battleController addObserver:self
                        forKeyPath:keyPathToAddObserver
                           options:(NSKeyValueObservingOptionNew)
                           context:&sRPGSkillsEffectsViewControllerSkillsEffects];
  }
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UINib *cellNIB = [UINib nibWithNibName:kRPGSkillsEffectsCollectionViewCellNIBName bundle:nil];
  [self.skillsEffectsCollectionView registerNib:cellNIB forCellWithReuseIdentifier:kRPGSkillsEffectsCollectionViewCellNIBName];
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
  RPGSkillsEffectsCollectionViewCell *cell = [aCollectionView dequeueReusableCellWithReuseIdentifier:kRPGSkillsEffectsCollectionViewCellNIBName
                                                                                        forIndexPath:anIndexPath];
  NSInteger index = anIndexPath.row;
  NSArray *skillsEffects = [self getSkillsEffectsForPlayerType:self.playerType];

  if (index < skillsEffects.count)
  {
    RPGSkillEffect *skillEffect = skillsEffects[index];
    
    cell.image = [UIImage imageNamed:@"battle_empty_icon_inactive"];
    cell.backgroundImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"skill_effect_%ld", (long)skillEffect.skillEffectID]];
    cell.backgroundImageView.layer.cornerRadius = kRPGSkillsEffectsViewControllerSkillEffectCellCornerRadius;
    cell.backgroundImageView.layer.masksToBounds = YES;
    
    cell.durationHidden = NO;
    cell.duration = skillEffect.duration;
    cell.durationView.layer.cornerRadius = cell.durationView.frame.size.height * kRPGSkillsEffectsViewControllerSkillEffectDurationViewCornerRadiusMultiplier;
    cell.durationView.layer.masksToBounds = YES;
  }
  else
  {
    [cell setImage:[UIImage imageNamed:@"battle_empty_icon_unset"]];
    cell.backgroundImageView.image = nil;
    
    cell.durationHidden = YES;
  }
  
  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  CGFloat viewWidth = self.skillsEffectsCollectionView.frame.size.width;
  CGFloat cellWidth = viewWidth / (CGFloat) kRPGSkillsEffectsViewControllerNumberOfCellsInRow;
  
  return CGSizeMake(cellWidth, cellWidth);
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

#pragma mark - Helpful Method

- (NSString *)keyPathForPlayerType:(RPGPlayerType)aPlayerType
{
  NSString *keyPathToRemoveObserver = nil;
  
  if (aPlayerType == kRPGPlayerTypePlayer)
  {
    keyPathToRemoveObserver = @"battle.playerSkillsEffects";
  }
  else if (aPlayerType == kRPGPlayerTypeOpponent)
  {
    keyPathToRemoveObserver = @"battle.opponentSkillsEffects";
  }
  
  return keyPathToRemoveObserver;
}

- (NSArray *)getSkillsEffectsForPlayerType:(RPGPlayerType)aPlayerType
{
  NSArray *skillsEffects = nil;
  RPGBattle *battle = self.battleController.battle;
  
  if (self.playerType == kRPGPlayerTypePlayer)
  {
    skillsEffects = battle.playerSkillsEffects;
  }
  else if (self.playerType == kRPGPlayerTypeOpponent)
  {
    skillsEffects = battle.opponentSkillsEffects;
  }
  
  return skillsEffects;
}

@end
