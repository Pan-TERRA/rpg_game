//
//  RPGArenaSkillsResponse.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
  // Misc
#import "RPGSerializable.h"

@interface RPGArenaSkillsResponse : NSObject <RPGSerializable>

@property (nonatomic, assign, readwrite) NSInteger status;
@property (nonatomic, retain, readwrite) NSArray *skills;

- (instancetype)initWithStatus:(NSInteger)aStatus skills:(NSArray *)aSkills;

@end

