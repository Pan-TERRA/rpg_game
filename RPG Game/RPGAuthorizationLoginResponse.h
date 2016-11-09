//
//  RPGAuthorizationLoginResponse.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGSerializable.h"

@interface RPGAuthorizationLoginResponse : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) NSInteger status;
@property (nonatomic, copy, readonly) NSString *username;
@property (nonatomic, copy, readonly) NSString *token;
@property (nonatomic, copy, readonly) NSString *avatar;
@property (nonatomic, assign, readonly) NSInteger gold;
@property (nonatomic, assign, readonly) NSInteger crystals;
@property (nonatomic, retain, readonly) NSDictionary *character;

#pragma mark - Init

- (instancetype)initWithUsername:(NSString *)aUsername
                           token:(NSString *)aToken
                          avatar:(NSString *)anAvatar
                            gold:(NSInteger)aGold
                        crystals:(NSInteger)aCrystals
                      character:(NSDictionary *)aCharacter
                          status:(NSInteger)aStatus NS_DESIGNATED_INITIALIZER;
+ (instancetype)responseWithUsername:(NSString *)aUsername
                               token:(NSString *)aToken
                              avatar:(NSString *)anAvatar
                                gold:(NSInteger)aGold
                            crystals:(NSInteger)aCrystals
                          character:(NSDictionary *)aCharacter
                              status:(NSInteger)aStatus;

#pragma mark - Actions

- (void)store;

@end
