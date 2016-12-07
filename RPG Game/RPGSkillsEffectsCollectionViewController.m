//
//  RPGSkillsEffectsCollectionViewController.m
//  RPG Game
//
//  Created by Максим Шульга on 12/7/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillsEffectsCollectionViewController.h"
  // Views
#import "RPGSkillsEffectsCollectionViewCell.h"
  // Entites
#import "RPGSkillEffect.h"
  // Constants
#import "RPGNibNames.h"

static NSUInteger const kRPGSkillsEffectsCollectionViewControllerCollectionSize = 6;
static CGFloat const kRPGSkillsEffectsCollectionViewControllerViewCornerRadiusMultiplier = 0.5;

@interface RPGSkillsEffectsCollectionViewController() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, assign, readwrite) UICollectionView *collectionView;
@property (nonatomic, assign, readwrite, getter=isTransformEnabled) BOOL transformEnabled;

@end

@implementation RPGSkillsEffectsCollectionViewController

#pragma mark - Init

- (instancetype)initWithCollectionView:(UICollectionView *)aCollectionView
                         skillsEffects:(NSArray<RPGSkillEffect *> *)aSkillsEffects
                      transformEnabled:(BOOL)aTransformEnabledFlag
{
  self = [super init];
  
  if (self != nil)
  {
    _collectionView = aCollectionView;
    _skillsEffects = [aSkillsEffects retain];
    _transformEnabled = aTransformEnabledFlag;
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    if (_transformEnabled)
    {
      _collectionView.transform = CGAffineTransformMakeScale(-1, 1);
    }
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithCollectionView:nil
                        skillsEffects:nil
                     transformEnabled:NO];
}

#pragma mark - Custom Setter

- (void)setSkillsEffects:(NSArray *)aSkillsEffects
{
  if (_skillsEffects != aSkillsEffects)
  {
    [_skillsEffects release];
    _skillsEffects = [aSkillsEffects retain];
  }
  
  [self.collectionView reloadData];
}

#pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)aCollectionView numberOfItemsInSection:(NSInteger)aSection
{
  return kRPGSkillsEffectsCollectionViewControllerCollectionSize;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)aCollectionView cellForItemAtIndexPath:(NSIndexPath *)anIndexPath
{
  RPGSkillsEffectsCollectionViewCell *cell = [aCollectionView dequeueReusableCellWithReuseIdentifier:kRPGSkillsEffectsCollectionViewCellNIBName
                                                                                        forIndexPath:anIndexPath];
  NSInteger index = anIndexPath.row;
  NSArray *skillsEffects = self.skillsEffects;
  
  if (index < skillsEffects.count)
  {
    RPGSkillEffect *skillEffect = skillsEffects[index];
    
    cell.image = [UIImage imageNamed:@"battle_empty_icon_inactive"];
    cell.backgroundImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"skill_effect_%ld", (long)skillEffect.skillEffectID]];
    
    cell.duration = skillEffect.duration;
    
    [self setCornerRadiusForView:cell.backgroundImageView];
    [self setCornerRadiusForView:cell.durationView];
  }
  
  cell.hidden = !(index < skillsEffects.count);
  cell.transformEnabled = self.isTransformEnabled;
  
  return cell;
}

- (CGSize)collectionView:(UICollectionView *)aCollectionView
                  layout:(UICollectionViewLayout *)aCollectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)anIndexPath
{
  CGFloat viewWidth = self.collectionView.frame.size.width;
  CGFloat cellWidth = viewWidth / (CGFloat) kRPGSkillsEffectsCollectionViewControllerCollectionSize;
  
  return CGSizeMake(cellWidth, cellWidth);
}

#pragma mark - Heplful Method

- (void)setCornerRadiusForView:(UIView *)aView
{
  aView.layer.cornerRadius = aView.frame.size.width * kRPGSkillsEffectsCollectionViewControllerViewCornerRadiusMultiplier;
  aView.layer.masksToBounds = YES;
}

@end
