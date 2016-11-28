//
//  RPGArenaSkillsResponse.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGSerializable.h"

@interface RPGArenaSkillsResponse : NSObject <RPGSerializable>

@property (nonatomic, assign, readwrite) NSInteger status;
@property (nonatomic, retain, readwrite) NSArray *skills;

- (instancetype)initWithStatus:(NSInteger)status skills:(NSArray *)skills;

@end

