//
//  RPGArenaCollectionViewController.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
  // Constants
#import "RPGItemTypes.h"

@protocol RPGArenaCollectionViewControllerDelegate <NSObject>

- (void)addSkillToSkillCollectionWithID:(NSUInteger)aSkillID;
- (UIViewController *)getViewController;

@end

@interface RPGArenaCollectionViewController : NSObject

@property (nonatomic, assign, readwrite) id<RPGArenaCollectionViewControllerDelegate> delegate;

@property (nonatomic, retain, readonly) NSArray *skillsIDArray;
@property (nonatomic, assign, readonly) NSUInteger numberOfCellsInRow;
@property (nonatomic, assign, readonly) NSUInteger collectionSize;
@property (nonatomic, assign, readonly) UICollectionView *collectionView;

- (instancetype)initWithCollectionView:(UICollectionView *)aCollectionView
                        collectionSize:(NSUInteger)aCollectionSize
                           skillsArray:(NSArray *)aSkillsArray NS_DESIGNATED_INITIALIZER;

- (void)addItem:(NSUInteger)anItemID
           type:(RPGItemType)aType;

/**
 *  Swaps item to another collection.
 */
- (void)moveItem:(NSUInteger)anItemID
            type:(RPGItemType)aType;

/**
 *  Template mehtod. Use this method to define move logic.
 *
 *  @warning Must be overridden
 */
- (void)addItemToOtherCollectionWithID:(NSUInteger)anItemID
                                  type:(RPGItemType)aType;

@end
