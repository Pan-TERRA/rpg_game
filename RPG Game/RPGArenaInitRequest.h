//
//  RPGArenaInitRequest.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGRequest.h"

@interface RPGArenaInitRequest : RPGRequest

@property (nonatomic, retain, readonly) NSArray *skillIDs;

- (instancetype)initWithSkillIDs:(NSArray *)aSkillIDs token:(NSString *)aToken NS_DESIGNATED_INITIALIZER;
+ (instancetype)requestWithSkillIDs:(NSArray *)aSkillIDs token:(NSString *)aToken;

@end
