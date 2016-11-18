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
#import "RPGSkillDescriptionViewController.h"
#import "RPGCharacterProfileViewController.h"

@interface RPGCollectionViewController() <UIGestureRecognizerDelegate>

@end

@implementation RPGCollectionViewController

#pragma mark - Init

- (instancetype)init
{
  self = [super init];
  
  if (self != nil)
  {
    //_skillsIDArray = [[NSMutableArray alloc] initWithObjects:@(1), @(5), @(3), @(4), nil];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_skillsIDArray release];
  
  [super dealloc];
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

- (void)setSkillsIDArray:(NSMutableArray *)skillsIDArray
{
  if (_skillsIDArray != skillsIDArray)
  {
    [_skillsIDArray release];
    _skillsIDArray = [skillsIDArray retain];
  }
  
  [self.collectionView reloadData];
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
      RPGSkillRepresentation *skillRepresentation = [RPGSkillRepresentation skillrepresentationWithSkillID:skillID];
      [cell setImage:[UIImage imageNamed:skillRepresentation.imageName]];
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
      NSUInteger skillID = [[self.skillsIDArray objectAtIndex:indexPath.row] integerValue];
      RPGSkillRepresentation *skillRepresentation = [RPGSkillRepresentation skillrepresentationWithSkillID:skillID];
      RPGSkillDescriptionViewController *viewController = [[[RPGSkillDescriptionViewController alloc] initWithSkillRepresentation:skillRepresentation] autorelease];
      
      RPGCharacterProfileViewController *parentViewController = self.viewController;
      [parentViewController addChildViewController:viewController];
      viewController.view.frame = parentViewController.view.frame;
      [parentViewController.view addSubview:viewController.view];
      [viewController didMoveToParentViewController:parentViewController];
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
  [self addToOtherCollectionSkillWithID:aSkillID];
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

-(void)addToOtherCollectionSkillWithID:(NSUInteger)aSkillID
{
  
}

@end
