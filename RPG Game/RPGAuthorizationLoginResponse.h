//
//  RPGAuthorizationLoginResponse.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kRPGLoginInfo;

@interface RPGAuthorizationLoginResponse : NSObject

@property (copy, nonatomic, readonly) NSString *username;
@property (copy, nonatomic, readonly) NSString *token;
@property (copy, nonatomic, readonly) NSString *avatar;

@property (nonatomic, readonly) NSInteger gold;
@property (nonatomic, readonly) NSInteger crystals;

@property (copy, nonatomic, readonly) NSArray *characters;

#pragma mark - Init

- (instancetype)initWithUsername:(NSString *)aUsername
                           token:(NSString *)aToken
                          avatar:(NSString *)anAvatar
                            gold:(NSInteger)aGold
                        crystals:(NSInteger)aCrystals
                      characters:(NSArray *)aCharacters;
+ (instancetype)responseWithUsername:(NSString *)aUsername
                               token:(NSString *)aToken
                              avatar:(NSString *)anAvatar
                                gold:(NSInteger)aGold
                            crystals:(NSInteger)aCrystals
                          characters:(NSArray *)aCharacters;

#pragma mark - Actions

- (void)store;

@end
