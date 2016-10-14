//
//  RPGAuthorizationLoginResponse.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPGAuthorizationLoginResponse : NSObject

@property (copy, nonatomic, readonly) NSString *username;
@property (copy, nonatomic, readonly) NSString *token;
@property (copy, nonatomic, readonly) NSString *avatar;

@property (nonatomic, readonly) NSInteger gold;
@property (nonatomic, readonly) NSInteger crystals;

@property (copy, nonatomic, readonly) NSDictionary *characters;

@end
