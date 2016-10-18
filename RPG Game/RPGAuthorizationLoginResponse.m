//
//  RPGAuthorizationLoginResponse.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAuthorizationLoginResponse+Serialization.h"
#import "UserSessionKeys.h"

NSString * const kRPGLoginInfo = @"loginInfo";

@interface RPGAuthorizationLoginResponse ()

@property (copy, nonatomic, readwrite) NSString *username;
@property (copy, nonatomic, readwrite) NSString *token;
@property (copy, nonatomic, readwrite) NSString *avatar;

@property (nonatomic, readwrite) NSInteger gold;
@property (nonatomic, readwrite) NSInteger crystals;

@property (copy, nonatomic, readwrite) NSArray *characters;

@end

@implementation RPGAuthorizationLoginResponse

@synthesize username = _username;
@synthesize token = _token;
@synthesize avatar = _avatar;

@synthesize gold = _gold;
@synthesize crystals = _crystals;

@synthesize characters = _characters;

#pragma mark - Init

- (instancetype)initWithUsername:(NSString *)aUsername
                           token:(NSString *)aToken
                          avatar:(NSString *)anAvatar
                            gold:(NSInteger)aGold
                        crystals:(NSInteger)aCrystals
                      characters:(NSArray *)aCharacters
{
  self = [super init];
  
  if (self != nil)
  {
    _username = [aUsername copy];
    _token = [aToken copy];
    _avatar = [anAvatar copy];
    _gold = aGold;
    _crystals = aCrystals;
    _characters = [aCharacters retain];
  }
  
  return self;
}

+ (instancetype)responseWithUsername:(NSString *)aUsername
                               token:(NSString *)aToken
                              avatar:(NSString *)anAvatar
                                gold:(NSInteger)aGold
                            crystals:(NSInteger)aCrystals
                          characters:(NSArray *)aCharacters
{
  return [[[self alloc] initWithUsername:aUsername token:aToken avatar:anAvatar gold:aGold crystals:aCrystals characters:aCharacters] autorelease];
}

- (instancetype)init
{
  return nil;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_username release];
  [_token release];
  [_avatar release];
  [_characters release];
  
  [super dealloc];
}

#pragma mark - Actions

- (void)store
{
  NSUserDefaults *standartUserDefaults = [NSUserDefaults standardUserDefaults];
  [standartUserDefaults setObject:self.username forKey:kRPGUserSessionKeyUsername];
  [standartUserDefaults setObject:self.token forKey:kRPGUserSessionKeyToken];
  [standartUserDefaults setObject:self.avatar forKey:kRPGUserSessionKeyAvatar];
  [standartUserDefaults setInteger:self.gold forKey:kRPGUserSessionKeyGold];
  [standartUserDefaults setInteger:self.crystals forKey:kRPGUserSessionKeyCrystals];
  [standartUserDefaults setObject:self.characters forKey:kRPGUserSessionKeyCharacters];
}

@end
