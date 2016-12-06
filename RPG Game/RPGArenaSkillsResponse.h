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

@property (nonatomic, assign, readonly) NSInteger status;
@property (nonatomic, retain, readonly) NSArray *skills;

- (instancetype)initWithStatus:(NSInteger)aStatus
                        skills:(NSArray *)aSkills NS_DESIGNATED_INITIALIZER;
+ (instancetype)responseWithStatus:(NSInteger)aStatus
                            skills:(NSArray *)aSkills;

@end
