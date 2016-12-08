//
//  RPGShopCollectionViewController.m
//  RPG Game
//
//  Created by Владислав Крут on 11/23/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGShopCollectionViewController.h"
  //View
#import "RPGShopViewController.h"
#import "RPGShopCollectionViewCell.h"
  //Entity
#import "RPGShopUnit.h"
  //Constants
#import "RPGNibNames.h"

@interface RPGShopCollectionViewController () <UICollectionViewDelegateFlowLayout, RPGShopCollectionViewCellDelegate>

@end

@implementation RPGShopCollectionViewController

static NSString * const reuseIdentifier = @"shopCollectionViewCell";

#pragma mark - Init

- (instancetype)init
{
  UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout new] autorelease];
  flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

  self = [super initWithCollectionViewLayout:flowLayout];
  
  if (self != nil)
  {
    _shopUnits = [NSMutableArray new];
    
    [self.collectionView registerClass:[RPGShopCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

    UINib *nib = [UINib nibWithNibName:kRPGShopCollectionViewCellNIBName bundle:nil];
    
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
  }
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_shopUnits release];
  
  [super dealloc];
}

#pragma mark - UIVIewController

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  self.view.backgroundColor = [UIColor clearColor];
  self.collectionView.backgroundColor = [UIColor clearColor];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
  return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return self.shopUnits.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  RPGShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
  
  if (cell == nil)
  {
    cell = [[RPGShopCollectionViewCell new] autorelease];
  }
  
  cell.shopUnit = self.shopUnits[indexPath.item];
  cell.delegate = self;
  
  return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  CGSize collectionViewSize = self.collectionView.frame.size;
  CGSize cellSize = CGSizeZero;
  
  if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
  {
    cellSize = CGSizeMake(collectionViewSize.width / 5.25, collectionViewSize.height / 2.35);
  }
  else
  {
    cellSize = CGSizeMake(collectionViewSize.width / 3.25, collectionViewSize.height / 1.05);
  }
  
  return cellSize;
}

- (void)buyButtonDidPressOnCell:(RPGShopCollectionViewCell *)aCell
{
  NSIndexPath *indexPath = [self.collectionView indexPathForCell:aCell];
  NSInteger shopUnitID = self.shopUnits[indexPath.item].unitID;
  
  RPGShopViewController *shopViewController = (RPGShopViewController *)self.parentViewController;
  [shopViewController buyShopUnitWithID:shopUnitID];
}



@end
