//
//  RPGSkill.h
//  RPG Game
//
//  Created by Максим Шульга on 11/17/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGSerializable.h"

@interface RPGCharacterProfileSkill : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) NSUInteger skillID;
@property (nonatomic, assign, readonly, getter=isSelected) BOOL selected;

- (instancetype)initWithID:(NSUInteger)aSkillID
                  selected:(BOOL)isSelected NS_DESIGNATED_INITIALIZER;
+ (instancetype)skillWithID:(NSUInteger)aSkillID
                   selected:(BOOL)isSelected;

@end
