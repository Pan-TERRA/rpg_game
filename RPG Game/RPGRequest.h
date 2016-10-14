//
//  RPGRequest.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Basic request class. Mainly used for static requests and "RPGBattleManager"
    socket messages.
 */
@interface RPGRequest : NSObject

@property (copy, readonly, nonatomic) NSString *type;
@property (copy, readonly, nonatomic) NSString *token;

#pragma mark - Init

- (instancetype)initWithType:(NSString *)aType token:(NSString *)aToken NS_DESIGNATED_INITIALIZER;
+ (instancetype)requestWithType:(NSString *)aType token:(NSString *)aToken;

@end
