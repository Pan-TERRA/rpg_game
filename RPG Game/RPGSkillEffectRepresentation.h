//
//  RPGSkillEffectRepresentation.h
//  RPG Game
//
//  Created by Максим Шульга on 12/9/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPGSkillEffectRepresentation : NSObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *skillEffectDescription;
@property (nonatomic, copy, readonly) NSString *imageName;

- (instancetype)initWithSkillEffectID:(NSInteger)aSkillID NS_DESIGNATED_INITIALIZER;
+ (instancetype)skillEffectRepresentationWithSkillEffectID:(NSInteger)aSkillEffectID;

@end
