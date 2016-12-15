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
  // Constants
#import "RPGStatusCodes.h"

@interface RPGArenaSkillsResponse : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) RPGStatusCode status;
@property (nonatomic, retain, readonly) NSArray<NSNumber *> *skills;

- (instancetype)initWithStatus:(RPGStatusCode)aStatus
                        skills:(NSArray<NSNumber *> *)aSkills NS_DESIGNATED_INITIALIZER;
+ (instancetype)responseWithStatus:(RPGStatusCode)aStatus
                            skills:(NSArray<NSNumber *> *)aSkills;

@end
