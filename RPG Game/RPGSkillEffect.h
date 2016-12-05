//
//  RPGSkillEffect.h
//  RPG Game
//
//  Created by Максим Шульга on 12/5/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
  // Misc
#import "RPGSerializable.h"

@interface RPGSkillEffect : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) NSInteger skillEffectID;
@property (nonatomic, assign, readonly) NSInteger duration;

- (instancetype)initWithSkillEffectID:(NSInteger)aSkillEffectID
                             duration:(NSInteger)aDuration NS_DESIGNATED_INITIALIZER;
+ (instancetype)skillEffectWithSkillEffectID:(NSInteger)aSkillEffectID
                                    duration:(NSInteger)aDuration;

@end
