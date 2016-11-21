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

@class RPGCharacterProfileViewController;

@interface RPGCollectionViewController : NSObject

@property (nonatomic, assign, readonly) RPGCharacterProfileViewController *viewController;

@property (nonatomic, retain, readwrite) NSMutableArray *skillsID;
@property (nonatomic, assign, readonly) NSUInteger numberOfCellsInRow;
@property (nonatomic, assign, readonly) NSUInteger collectionSize;

- (instancetype)initWithCollectionView:(UICollectionView *)aCollectionView
                  parentViewController:(RPGCharacterProfileViewController *)aViewController
                        collectionSize:(NSUInteger)aCollectionSize;

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
