//
//  RPGPlayerInfo.h
//  RPG Game
//
//  Created by Максим Шульга on 12/5/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
// Misc
#import "RPGSerializable.h"

@class RPGSkillEffect;

@interface RPGPlayerInfo : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) NSInteger HP;
@property (nonatomic, assign, readonly) NSArray<RPGSkillEffect *> *skillsEffects;

- (instancetype)initWithHP:(NSInteger)aHP
             skillsEffects:(NSArray<RPGSkillEffect *> *)aSkillsEffects NS_DESIGNATED_INITIALIZER;
+ (instancetype)playerInfoWithHP:(NSInteger)aHP
                   skillsEffects:(NSArray<RPGSkillEffect *> *)aSkillsEffects;

@end
