//
//  RPGResponse.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Basic response class. Mainly used by "RPGBattleManager".
 */
@interface RPGResponse : NSObject

@property (copy, readonly, nonatomic) NSString *type;
@property (readonly, nonatomic) int status;

#pragma mark - Init

- (instancetype)initWithType:(NSString *)aType status:(int)aStatus NS_DESIGNATED_INITIALIZER;
+ (instancetype)requestWithType:(NSString *)aType status:(int)aStatus;

@end
