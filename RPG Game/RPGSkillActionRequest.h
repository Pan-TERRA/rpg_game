//
//  RPGSkillCondtion.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGRequest.h"

extern NSString * const kRPGSkillActionRequestType;

@interface RPGSkillActionRequest : RPGRequest

@property (nonatomic, assign, readonly) NSInteger skillID;

- (instancetype)initWithSkillID:(NSInteger)aSkillID NS_DESIGNATED_INITIALIZER;
+ (instancetype)requestWithSkillID:(NSInteger)aSkillID;

@end
