  //
  //  RPGCollectionController.h
  //  RPG Game
  //
  //  Created by Максим Шульга on 11/17/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import <UIKit/UIKit.h>
  // Controllers
@class RPGCollectionViewController;
  // Entities
@class RPGCharacterProfileSkill;
  // Constants
#import "RPGItemTypes.h"

@protocol RPGCollectionViewControllerDelegate <NSObject>

- (void)reloadCollection:(RPGCollectionViewController *)aCollectionViewController;
- (BOOL)canAddToCollectionWithCurrentSize:(NSInteger)aSize;

@end

extern NSInteger kRPGCollectionViewControllerSkillButtonCornerRadius;

@interface RPGCollectionViewController : NSObject

@property (nonatomic, assign, readwrite) id<RPGCollectionViewControllerDelegate> delegate;

@property (nonatomic, assign, readonly) NSArray<NSNumber *> *skillIDArray;
@property (nonatomic, assign, readonly) NSArray<RPGCharacterProfileSkill *> *skills;
@property (nonatomic, assign, readonly) NSArray<RPGCharacterProfileSkill *> *validatedSkills;

@property (nonatomic, assign, readonly) UICollectionView *collectionView;
@property (nonatomic, assign, readonly) NSUInteger collectionSize;
@property (nonatomic, assign, readonly) NSUInteger numberOfCellsInRow;

- (instancetype)initWithCollectionView:(UICollectionView *)aCollectionView
                        collectionSize:(NSUInteger)aCollectionSize
                                skills:(NSMutableArray *)aSkills;

- (instancetype)initWithCollectionView:(UICollectionView *)aCollectionView
                        collectionSize:(NSUInteger)aCollectionSize
                                skills:(NSMutableArray *)aSkills
                  shouldValidateSkills:(BOOL)aShouldValidateSkills NS_DESIGNATED_INITIALIZER;

  // template method
- (BOOL)validateSkill:(RPGCharacterProfileSkill *)aSkill;

/**
 *  Swaps item to another collection.
 */
- (void)moveItem:(RPGCharacterProfileSkill *)anItem type:(RPGItemType)aType;

@end
