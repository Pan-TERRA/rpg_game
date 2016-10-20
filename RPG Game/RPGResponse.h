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

@property (nonatomic, copy, readonly) NSString *type;
@property (nonatomic, assign, readonly) NSInteger status;

#pragma mark - Init

- (instancetype)initWithType:(NSString *)aType
                      status:(NSInteger)aStatus NS_DESIGNATED_INITIALIZER;
+ (instancetype)responseWithType:(NSString *)aType
                          status:(NSInteger)aStatus;

@end
