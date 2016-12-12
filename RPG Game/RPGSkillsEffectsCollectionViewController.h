  //
  //  RPGSkillsEffectsCollectionViewController.h
  //  RPG Game
  //
  //  Created by Максим Шульга on 12/7/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import <UIKit/UIKit.h>
  // Entities
@class RPGSkillEffect;
  // Constants
#import "RPGAlign.h"

@interface RPGSkillsEffectsCollectionViewController : NSObject

@property (nonatomic, retain, readwrite) NSArray<NSNumber *> *skillsEffects;

- (instancetype)initWithCollectionView:(UICollectionView *)aCollectionView
                         skillsEffects:(NSArray<NSNumber *> *)aSkillsEffects
                                 align:(RPGAlign)anAlign NS_DESIGNATED_INITIALIZER;

+ (instancetype)skillEffectsControllerWithCollectionView:(UICollectionView *)aCollectionView
                                           skillsEffects:(NSArray<NSNumber *> *)aSkillsEffects
                                                   align:(RPGAlign)anAlign;

@end
