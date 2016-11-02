//
//  RPGSkillRepresentation.h
//  RPG Game
//
//  Created by Владислав Крут on 11/2/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kRPGSkillRepresentationName;
extern NSString * const kRPGSkillRepresentationSpecification;
extern NSString * const kRPGSkillRepresentationMultiplier;
extern NSString * const kRPGSkillRepresentationCooldown;
extern NSString * const kRPGSkillRepresentationImageName;
extern NSString * const kRPGSkillRepresentationSoundName;

@interface RPGSkillRepresentation : NSObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *specification;
@property (nonatomic, assign, readonly) float multiplier;
@property (nonatomic, assign, readonly) NSInteger cooldown;
@property (nonatomic, copy, readonly) NSString *imageName;
@property (nonatomic, copy, readonly) NSString *soundName;

- (instancetype)initWithSkillID:(NSInteger)aSkillID;

@end
