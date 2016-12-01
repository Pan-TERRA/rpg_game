//
//  RPGAvatarCollectionViewController.m
//  RPG Game
//
//  Created by Максим Шульга on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAvatarCollectionViewController.h"
// Views
#import "RPGAvatarCollectionViewCell.h"
// Misc
#import "UIViewController+RPGChildViewController.h"
// Constants
#import "RPGNibNames.h"

static NSInteger kRPGAvatarCollectionViewControllerSize = 10;

@interface RPGAvatarCollectionViewController() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, assign, readwrite) UIViewController *viewController;
@property (nonatomic, assign, readwrite) UICollectionView *collectionView;
@property (nonatomic, assign, readwrite) NSInteger selectedAvatarIndex;

@end

@implementation RPGAvatarCollectionViewController

#pragma mark - Init

- (instancetype)initWithCollectionView:(UICollectionView *)aCollectionView
                  parentViewController:(UIViewController *)aViewController
                   selectedAvatarIndex:(NSInteger)anIndex
{
  self = [super init];
  
  if (self != nil)
  {
    _collectionView = aCollectionView;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    _viewController = aViewController;
    _selectedAvatarIndex = anIndex;
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithCollectionView:nil
                 parentViewController:nil
                  selectedAvatarIndex:-1];
}

#pragma mark - Custom Setter

- (void)setCharacterClassID:(NSInteger)aCharacterClassID
{
  _characterClassID = aCharacterClassID;
  [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)aCollectionView numberOfItemsInSection:(NSInteger)aSection
{
  return kRPGAvatarCollectionViewControllerSize;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)aCollectionView cellForItemAtIndexPath:(NSIndexPath *)anIndexPath
{
  RPGAvatarCollectionViewCell *cell = [aCollectionView dequeueReusableCellWithReuseIdentifier:kRPGAvatarCollectionViewCellNIBName
                                                                                 forIndexPath:anIndexPath];
  NSInteger index = anIndexPath.row;
  
  UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"avatar_%ld_%ld", (long)self.characterClassID, (long)index]];
  if (image != nil)
  {
    [cell setImage:image];
  }
  else
  {
    [cell setImage:[UIImage imageNamed:@"battle_empty_icon_lock"]];
  }
  
  [cell setChosenFlagImageViewHidden:!(index == self.selectedAvatarIndex)];

  return cell;
}

- (CGSize)collectionView:(UICollectionView *)aCollectionView
                  layout:(UICollectionViewLayout *)aCollectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)anIndexPath
{
  CGFloat viewHeight = self.collectionView.frame.size.height;
  return CGSizeMake(viewHeight, viewHeight);
}

- (void)collectionView:(UICollectionView *)aCollectionView didSelectItemAtIndexPath:(NSIndexPath *)anIndexPath
{
  NSIndexPath *path = [NSIndexPath indexPathForRow:self.selectedAvatarIndex inSection:0];
  RPGAvatarCollectionViewCell *cell = (RPGAvatarCollectionViewCell *)[aCollectionView cellForItemAtIndexPath:path];
  [cell setChosenFlagImageViewHidden:YES];
  
  self.selectedAvatarIndex = anIndexPath.row;
  cell = (RPGAvatarCollectionViewCell *)[aCollectionView cellForItemAtIndexPath:anIndexPath];
  [cell setChosenFlagImageViewHidden:NO];
}

@end
