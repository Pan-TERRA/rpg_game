//
//  RPGCollectionController.m
//  RPG Game
//
//  Created by Максим Шульга on 11/17/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGCollectionViewController.h"
#import "RPGCharacterBagCollectionViewCell.h"
#import "RPGSkillRepresentation.h"
#import "RPGNibNames.h"

@interface RPGCollectionViewController() <UIGestureRecognizerDelegate>

@end

@implementation RPGCollectionViewController

- (instancetype)init
{
  self = [super init];
  
  if (self != nil)
  {
    _skillsIDArray = [[NSMutableArray alloc] initWithObjects:@(1), @(5), nil];
  }
  
  return self;
}
#pragma mark - Custom Setter

- (void)setCollectionView:(UICollectionView *)aCollectionView
{
  _collectionView = aCollectionView;
  UILongPressGestureRecognizer *gestureRecognizer = [[[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                   action:@selector(handleLongPress:)] autorelease];
  gestureRecognizer.delegate = self;
  gestureRecognizer.minimumPressDuration = 1;
  [self.collectionView addGestureRecognizer:gestureRecognizer];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)aCollectionView cellForItemAtIndexPath:(NSIndexPath *)anIndexPath
{
  RPGCharacterBagCollectionViewCell *cell = (RPGCharacterBagCollectionViewCell *)[aCollectionView dequeueReusableCellWithReuseIdentifier:kRPGCharacterBagCollectionViewCellNIBName forIndexPath:anIndexPath];
  
  NSInteger index = anIndexPath.row;
  if (index < self.collectionSize)
  {
    if (index < [self.skillsIDArray count])
    {
      NSUInteger skillID = [[self.skillsIDArray objectAtIndex:index] integerValue];
      RPGSkillRepresentation *skillRespesantation = [RPGSkillRepresentation skillrepresentationWithSkillID:skillID];
      [cell setImage:[UIImage imageNamed:skillRespesantation.imageName]];
    }
    else
    {
      [cell setImage:[UIImage imageNamed:@"_897769296"]];
    }
  }
  else
  {
    [cell setImage:[UIImage imageNamed:@"_967740272"]];
  }
  
  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  CGFloat viewWidth = self.collectionView.frame.size.width;
  CGFloat cellWidth = viewWidth * self.cellMultiplier;
  return CGSizeMake(cellWidth, cellWidth);
}

#pragma mark - Action Long Press

- (void)handleLongPress:(UILongPressGestureRecognizer *)aGestureRecognizer
{
  if (aGestureRecognizer.state == UIGestureRecognizerStateBegan) {
    CGPoint point = [aGestureRecognizer locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    if (indexPath != nil)
    {
      //show skill description screen
    }
  }
}

- (void)addSkill:(NSUInteger)aSkillID
{
  if ([self.skillsIDArray count] >= self.collectionSize)
  {
    [self removeSkill:[[self.skillsIDArray lastObject] integerValue]];
  }
  [self.skillsIDArray addObject:@(aSkillID)];
  
  [self.collectionView reloadData];
}

- (void)removeSkill:(NSUInteger)aSkillID
{
  [self.skillsIDArray removeObject:@(aSkillID)];
  
  [self.collectionView reloadData];
}

- (void)collectionView:(UICollectionView *)aCollectionView didSelectItemAtIndexPath:(NSIndexPath *)anIndexPath
{
  NSInteger index = anIndexPath.row;
  if (index < [self.skillsIDArray count])
  {
    NSUInteger skillID = [[self.skillsIDArray objectAtIndex:index] integerValue];
    [self removeSkill:skillID];
  }
}

@end
