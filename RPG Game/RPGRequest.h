//
//  RPGRequest.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGSerializable.h"

extern NSString *const kRPGRequestSerializationType;
extern NSString *const kRPGRequestSerializationToken;

/**
 *  Basic request class. Mainly used for static requests and "RPGBattleManager"
 *  socket messages.
 *  @warning R
 */
@interface RPGRequest : NSObject <RPGSerializable>

@property (nonatomic, copy, readonly) NSString *type;
@property (nonatomic, copy, readonly) NSString *token;

#pragma mark - Init

- (instancetype)initWithType:(NSString *)aType
                       token:(NSString *)aToken NS_DESIGNATED_INITIALIZER;
+ (instancetype)requestWithType:(NSString *)aType
                          token:(NSString *)aToken;

@end
