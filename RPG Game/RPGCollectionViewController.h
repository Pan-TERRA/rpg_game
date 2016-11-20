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

@interface RPGCollectionViewController : NSObject <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, assign, readwrite) RPGCharacterProfileViewController *viewController;
@property (nonatomic, assign, readwrite) UICollectionView *collectionView;

@property (nonatomic, retain, readwrite) NSMutableArray *skillsIDArray;
@property (nonatomic, assign, readonly) CGFloat cellMultiplier;
@property (nonatomic, assign, readwrite) NSUInteger collectionSize;

- (void)addItem:(NSUInteger)anItemID type:(RPGItemType)aType;
- (void)removeItem:(NSUInteger)anItemID type:(RPGItemType)aType;

/**
 *  Moves item to another collection.
 */
- (void)moveItem:(NSUInteger)anItemID type:(RPGItemType)aType;

/**
 *  Template mehtod. Use this method to define move logic.
 *
 *  @warning Must be override
 */
- (void)addItemToOtherCollectionWithID:(NSUInteger)anItemID type:(RPGItemType)aType;

@end
