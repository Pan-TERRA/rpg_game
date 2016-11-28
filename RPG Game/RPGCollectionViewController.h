//
//  RPGCollectionController.h
//  RPG Game
//
//  Created by Максим Шульга on 11/17/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
  // Constants
#import "RPGItemTypes.h"

//@class RPGCharacterProfileViewController;

@interface RPGCollectionViewController : NSObject

@property (nonatomic, assign, readonly) UIViewController *viewController;

@property (nonatomic, retain, readonly) NSArray *skillsIDArray;
@property (nonatomic, assign, readonly) NSUInteger numberOfCellsInRow;
@property (nonatomic, assign, readonly) NSUInteger collectionSize;
@property (nonatomic, assign, readonly) UICollectionView *collectionView;

- (instancetype)initWithCollectionView:(UICollectionView *)aCollectionView
                  parentViewController:(UIViewController *)aViewController
                        collectionSize:(NSUInteger)aCollectionSize
                           skillsArray:(NSArray *)aSkillsArray;

- (void)addItem:(NSUInteger)anItemID type:(RPGItemType)aType;
- (void)removeItem:(NSUInteger)anItemID type:(RPGItemType)aType;

/**
 *  Swaps item to another collection.
 */
- (void)moveItem:(NSUInteger)anItemID type:(RPGItemType)aType;

/**
 *  Template mehtod. Use this method to define move logic.
 *
 *  @warning Must be overridden
 */
- (void)addItemToOtherCollectionWithID:(NSUInteger)anItemID type:(RPGItemType)aType;

@end
