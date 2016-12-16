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
  // Views
@class RPGCollectionViewController;
  // Entities
@class RPGCharacterProfileSkill;

@protocol RPGCollectionViewControllerDelegate <NSObject>

- (void)reloadCollection:(RPGCollectionViewController *)aCollectionViewController;
- (BOOL)canAddToCollectionWithCurrentSize:(NSInteger)aSize;

@end

@interface RPGCollectionViewController : NSObject

@property (nonatomic, assign, readwrite) id<RPGCollectionViewControllerDelegate> delegate;

@property (nonatomic, assign, readonly) NSArray<NSNumber *> *skillsIDArray;
@property (nonatomic, assign, readonly) NSArray<RPGCharacterProfileSkill *> *skillsArray;
@property (nonatomic, assign, readonly) NSArray<RPGCharacterProfileSkill *> *validatedSkillsArray;

@property (nonatomic, assign, readonly) NSUInteger numberOfCellsInRow;
@property (nonatomic, assign, readonly) NSUInteger collectionSize;
@property (nonatomic, assign, readonly) UICollectionView *collectionView;

- (instancetype)initWithCollectionView:(UICollectionView *)aCollectionView
                        collectionSize:(NSUInteger)aCollectionSize
                           skillsArray:(NSMutableArray<RPGCharacterProfileSkill *> *)aSkillsArray;

- (instancetype)initWithCollectionView:(UICollectionView *)aCollectionView
                        collectionSize:(NSUInteger)aCollectionSize
                           skillsArray:(NSMutableArray<RPGCharacterProfileSkill *> *)aSkillsArray
         shouldUseValidatedSkillsArray:(BOOL)aValidateSkillsArrayFlag NS_DESIGNATED_INITIALIZER;

- (NSArray<RPGCharacterProfileSkill *> *)validatedSkillsArray:(BOOL)aFlag;
- (BOOL)canSelectItem:(RPGCharacterProfileSkill *)anItem;

/**
 *  Swaps item to another collection.
 */
- (void)moveItem:(RPGCharacterProfileSkill *)anItem
            type:(RPGItemType)aType;

@end
