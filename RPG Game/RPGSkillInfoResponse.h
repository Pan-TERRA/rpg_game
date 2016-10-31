//
//  RPGSkillInfoResponse.h
//  RPG Game
//
//  Created by Степан Супинский on 10/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPGSkillInfoResponse : NSObject

@property (assign, nonatomic, readwrite) NSInteger status;
@property (copy, nonatomic, readwrite) NSDictionary *skill;

- (instancetype)initWithStatus:(NSInteger)status skill:(NSDictionary *)skill;

@end
