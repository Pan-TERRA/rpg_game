//
//  RPGSkillsEffectsCollectionViewController.h
//  RPG Game
//
//  Created by Максим Шульга on 12/7/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RPGSkillEffect;

@interface RPGSkillsEffectsCollectionViewController : NSObject

@property (nonatomic, retain, readwrite) NSArray<RPGSkillEffect *> *skillsEffects;

- (instancetype)initWithCollectionView:(UICollectionView *)aCollectionView
                         skillsEffects:(NSArray<RPGSkillEffect *> *)aSkillsEffects
                      transformEnabled:(BOOL)aTransformEnabledFlag NS_DESIGNATED_INITIALIZER;

@end
