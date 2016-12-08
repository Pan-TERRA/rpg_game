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

@property (nonatomic, assign, readonly) NSInteger skillID;
@property (nonatomic, assign, readwrite, getter=isSelected) BOOL selected;

- (instancetype)initWithID:(NSInteger)aSkillID
                  selected:(BOOL)isSelected NS_DESIGNATED_INITIALIZER;
+ (instancetype)skillWithID:(NSInteger)aSkillID
                   selected:(BOOL)isSelected;

@end
