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

@property (assign, nonatomic, readonly) NSInteger skillID;

- (instancetype)initWithSkillID:(NSInteger)aSkillID token:(NSString *)aToken NS_DESIGNATED_INITIALIZER;
+ (instancetype)requestWithSkillID:(NSInteger)aSkillID token:(NSString *)aToken;

@end
