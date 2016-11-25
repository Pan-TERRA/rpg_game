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

    UINib *nib = [UINib nibWithNibName:kRPGShopCollectionViewCellNIBName bundle: nil];
    
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

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self.collectionView setNeedsUpdateConstraints];
  [self.collectionView setNeedsDisplay];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  self.view.backgroundColor = [UIColor clearColor];
  self.collectionView.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
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

#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  //TODO: remove this shit
  CGSize size = self.view.frame.size;
  size.width = size.width / 3.25;
  return size;
}

- (void)buyButtonDidPressOnCell:(RPGShopCollectionViewCell *)aCell
{
  NSIndexPath *indexPath = [self.collectionView indexPathForCell:aCell];
  NSInteger shopUnitID = self.shopUnits[indexPath.item].unitID;
  
  RPGShopViewController *shopViewController = (RPGShopViewController *)self.parentViewController;
  [shopViewController buyShopUnitWithID:shopUnitID];
  
}

#pragma mark - Accessors
- (void)setShopUnits:(NSArray<RPGShopUnit *> *)shopUnits
{
  if (_shopUnits != shopUnits)
  {
    [_shopUnits release];
    _shopUnits = [shopUnits retain];
    [self.collectionView reloadData];
  }
}
@end
