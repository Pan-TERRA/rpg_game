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

@interface RPGSkillsEffectsCollectionViewController() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, assign, readwrite) UICollectionView *collectionView;
@property (nonatomic, assign, readwrite) RPGSkillsEffectsCollectionViewAlign align;

@end

@implementation RPGSkillsEffectsCollectionViewController

#pragma mark - Init

- (instancetype)initWithCollectionView:(UICollectionView *)aCollectionView
                         skillsEffects:(NSArray<RPGSkillEffect *> *)aSkillsEffects
                                 align:(RPGSkillsEffectsCollectionViewAlign)anAlign
{
  self = [super init];
  
  if (self != nil)
  {
    _collectionView = aCollectionView;
    _skillsEffects = [aSkillsEffects retain];
    _align = anAlign;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    if (anAlign == kRPGSkillsEffectsCollectionViewAlignRight)
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
                                align:kRPGSkillsEffectsCollectionViewAlignLeft];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_skillsEffects release];
  
  [super dealloc];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)aCollectionView numberOfItemsInSection:(NSInteger)aSection
{
  return kRPGSkillsEffectsCollectionViewControllerCollectionSize;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)aCollectionView cellForItemAtIndexPath:(NSIndexPath *)anIndexPath
{
  RPGSkillsEffectsCollectionViewCell *cell = [aCollectionView
                                              dequeueReusableCellWithReuseIdentifier:kRPGSkillsEffectsCollectionViewCellNIBName
                                              forIndexPath:anIndexPath];
  NSInteger index = anIndexPath.row;
  NSArray *skillsEffects = self.skillsEffects;
  
  if (index < skillsEffects.count)
  {
    RPGSkillEffect *skillEffect = skillsEffects[index];
    
    cell.image = [UIImage imageNamed:@"battle_empty_icon_inactive"];
    cell.backgroundImage = [UIImage imageNamed:[NSString stringWithFormat:@"skill_effect_%ld", (long)skillEffect.skillEffectID]];
    
    cell.duration = skillEffect.duration;
  }
  
  cell.hidden = !(index < skillsEffects.count);
  cell.align = self.align;
  
  return cell;
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)aCollectionView
                  layout:(UICollectionViewLayout *)aCollectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)anIndexPath
{
  CGFloat viewWidth = self.collectionView.frame.size.width;
  CGFloat cellWidth = viewWidth / (CGFloat) kRPGSkillsEffectsCollectionViewControllerCollectionSize;
  
  return CGSizeMake(cellWidth, cellWidth);
}

@end
