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

@class RPGCollectionViewController;
@class RPGCharacterProfileSkill;

@protocol RPGCollectionViewControllerDelegate <NSObject>

- (void)reloadCollection:(RPGCollectionViewController *)aCollectionViewController;
- (BOOL)canAddToCollectionWithCurrentSize:(NSInteger)aSize;

@end

extern NSInteger kRPGCollectionViewControllerSkillButtonCornerRadius;

@interface RPGCollectionViewController : NSObject

@property (nonatomic, assign, readwrite) id<RPGCollectionViewControllerDelegate> delegate;

@property (nonatomic, assign, readonly) NSArray *skillsIDArray;
@property (nonatomic, assign, readonly) NSArray *skillsArray;
@property (nonatomic, assign, readonly) NSArray *validatedSkillsArray;

@property (nonatomic, assign, readonly) NSUInteger numberOfCellsInRow;
@property (nonatomic, assign, readonly) NSUInteger collectionSize;
@property (nonatomic, assign, readonly) UICollectionView *collectionView;

- (instancetype)initWithCollectionView:(UICollectionView *)aCollectionView
                        collectionSize:(NSUInteger)aCollectionSize
                           skillsArray:(NSMutableArray *)aSkillsArray;

- (instancetype)initWithCollectionView:(UICollectionView *)aCollectionView
                        collectionSize:(NSUInteger)aCollectionSize
                           skillsArray:(NSMutableArray *)aSkillsArray
         shouldUseValidatedSkillsArray:(BOOL)aValidateSkillsArrayFlag NS_DESIGNATED_INITIALIZER;

- (NSArray *)validatedSkillsArray:(BOOL)aFlag;
- (BOOL)canSelectItem:(RPGCharacterProfileSkill *)anItem;

/**
 *  Swaps item to another collection.
 */
- (void)moveItem:(RPGCharacterProfileSkill *)anItem type:(RPGItemType)aType;

@end
