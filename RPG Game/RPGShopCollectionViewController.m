//
//  RPGShopCollectionViewController.m
//  RPG Game
//
//  Created by Владислав Крут on 11/23/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGShopCollectionViewController.h"
#import "RPGShopCollectionViewCell.h"
#import "RPGNibNames.h"

@interface RPGShopCollectionViewController () <UICollectionViewDelegateFlowLayout>

@end

@implementation RPGShopCollectionViewController

static NSString * const reuseIdentifier = @"shopCollectionViewCell";

- (instancetype)init
{
  UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout new] autorelease];
  flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
  
  self = [super initWithCollectionViewLayout:flowLayout];
  if (self != nil)
  {
    [self.collectionView registerClass:[RPGShopCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

    UINib *nib = [UINib nibWithNibName:kRPGShopCollectionViewCellNIBName bundle: nil];
    
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
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
  return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  RPGShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
  
  if (cell == nil)
  {
    cell = [[RPGShopCollectionViewCell alloc] init];
  }
  
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
  CGSize size = self.view.frame.size;
  size.height = size.height * 0.9;
  size.width = size.width / 3.25;
  return size;
}

@end
