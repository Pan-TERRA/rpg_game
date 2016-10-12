//
//  RPGResponse.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Basic response class. Mainly used "RPGBattleManager" socket messages.
 */
@interface RPGResponse : NSObject

@property (copy, readonly, nonatomic) NSString *type;

#pragma mark - Init

- (instancetype)initWithType:(NSString *)aType NS_DESIGNATED_INITIALIZER;
+ (instancetype)requestWithType:(NSString *)aType;

@end
