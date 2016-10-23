//
//  RPGAuthorizationLoginResponse.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAuthorizationLoginResponse+Serialization.h"
#import "RPGUserSessionKeys.h"

@interface RPGAuthorizationLoginResponse ()

@property (nonatomic, assign, readwrite) NSInteger status;
@property (nonatomic, copy, readwrite) NSString *username;
@property (nonatomic, copy, readwrite) NSString *token;
@property (nonatomic, copy, readwrite) NSString *avatar;
@property (nonatomic, assign, readwrite) NSInteger gold;
@property (nonatomic, assign, readwrite) NSInteger crystals;
@property (nonatomic, retain, readwrite) NSDictionary *character;

@end

@implementation RPGAuthorizationLoginResponse

#pragma mark - Init

- (instancetype)initWithUsername:(NSString *)aUsername
                           token:(NSString *)aToken
                          avatar:(NSString *)anAvatar
                            gold:(NSInteger)aGold
                        crystals:(NSInteger)aCrystals
                      character:(NSDictionary *)aCharacter
                          status:(NSInteger)aStatus
{
  self = [super init];
  
  if (self != nil)
  {
    if (
        aStatus == 0 &&
        (aUsername == nil ||
        aToken == nil ||
        anAvatar == nil ||
        aGold < 0 ||
        aCrystals < 0 ||
        aCharacter == nil))
    {
      [self release];
      self = nil;
    }
    else if (aStatus != 0 &&
             (aUsername == nil ||
              aToken == nil ||
              anAvatar == nil ||
              aGold < 0 ||
              aCrystals < 0 ||
              aCharacter == nil))
    {
      _status = aStatus;
      _username = nil;
      _token = nil;
      _avatar = nil;
      _gold = -1;
      _crystals = -1;
      _character = nil;
      
    }
    else
    {
      _status = aStatus;
      _username = [aUsername copy];
      _token = [aToken copy];
      _avatar = [anAvatar copy];
      _gold = aGold;
      _crystals = aCrystals;
      _character = [aCharacter retain];
    }
  }
  
  return self;
}

+ (instancetype)responseWithUsername:(NSString *)aUsername
                               token:(NSString *)aToken
                              avatar:(NSString *)anAvatar
                                gold:(NSInteger)aGold
                            crystals:(NSInteger)aCrystals
                          character:(NSDictionary *)aCharacter
                              status:(NSInteger)aStatus
{
  return [[[self alloc] initWithUsername:aUsername
                                   token:aToken
                                  avatar:anAvatar
                                    gold:aGold
                                crystals:aCrystals
                              character:aCharacter
                                  status:aStatus] autorelease];
}

- (instancetype)init
{
  return [self initWithUsername:nil
                          token:nil
                         avatar:nil
                           gold:-1
                       crystals:-1
                     character:nil
                         status:0];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_username release];
  [_token release];
  [_avatar release];
  [_character release];
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
  [standartUserDefaults setObject:self.character forKey:kRPGUserSessionKeyCharacters];
}

@end
