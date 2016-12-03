//
//  RPGSkillRepresentation.h
//  RPG Game
//
//  Created by Владислав Крут on 11/2/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPGSkillRepresentation : NSObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *skillDescription;
@property (nonatomic, assign, readonly) float multiplier;
@property (nonatomic, assign, readonly) NSInteger absoluteCooldown;
@property (nonatomic, assign, readwrite) NSInteger remainingCooldown;
@property (nonatomic, copy, readonly) NSString *imageName;
@property (nonatomic, copy, readonly) NSString *soundName;
@property (nonatomic, assign, readonly) NSInteger requiredLevel;

- (instancetype)initWithSkillID:(NSInteger)aSkillID;
+ (instancetype)skillrepresentationWithSkillID:(NSInteger)aSkillID;

@end
