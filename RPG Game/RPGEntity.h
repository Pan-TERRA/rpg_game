//
//  RPGEntity.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPGEntity : NSObject

@property (copy, nonatomic, readonly) NSString *name;
@property (assign, nonatomic, readonly) NSInteger HP;

- (instancetype)initWithName:(NSString *)aName HP:(NSInteger)aHP;
+ (instancetype)entityWithName:(NSString *)aName HP:(NSInteger)aHP;

@end
