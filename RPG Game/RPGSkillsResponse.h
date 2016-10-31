//
//  RPGSkillsResponse.h
//  RPG Game
//
//  Created by Степан Супинский on 10/28/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGResponse.h"

@interface RPGSkillsResponse : NSObject

@property (assign, nonatomic, readwrite) NSInteger status;
@property (copy, nonatomic, readwrite) NSArray *skills;

- (instancetype)initWithStatus:(NSInteger)status skills:(NSArray *)skills;

@end
