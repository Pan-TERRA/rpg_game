//
//  RPGAuthorizationLoginResponse.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAuthorizationLoginResponse.h"
#import "NSUserDefaults+RPGSessionInfo.h"

static NSString * const kRPGAuthorizationLoginResponseStatus = @"status";
static NSString * const kRPGAuthorizationLoginResponseUsername = @"username";
static NSString * const kRPGAuthorizationLoginResponseToken = @"token";
static NSString * const kRPGAuthorizationLoginResponseAvatar = @"avatar";
static NSString * const kRPGAuthorizationLoginResponseGold = @"gold";
static NSString * const kRPGAuthorizationLoginResponseCrystals = @"crystals";
static NSString * const kRPGAuthorizationLoginResponseCharacter = @"characters";

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
    //?
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
  standartUserDefaults.sessionToken = self.token;
  standartUserDefaults.sessionUsername = self.username;
  standartUserDefaults.sessionAvatar = self.avatar;
  standartUserDefaults.sessionGold = self.gold;
  standartUserDefaults.sessionCrystals = self.crystals;
  // TODO: characters array instead of one character
  standartUserDefaults.sessionCharacters = [NSArray arrayWithObject:self.character];
}

#pragma mark - RPGSerialization 

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGAuthorizationLoginResponseStatus] = @(self.status);
  dictionaryRepresentation[kRPGAuthorizationLoginResponseUsername] = self.username;
  dictionaryRepresentation[kRPGAuthorizationLoginResponseToken] = self.token;
  dictionaryRepresentation[kRPGAuthorizationLoginResponseAvatar] = self.avatar;
  dictionaryRepresentation[kRPGAuthorizationLoginResponseGold] = @(self.gold);
  dictionaryRepresentation[kRPGAuthorizationLoginResponseCrystals] = @(self.crystals);
  dictionaryRepresentation[kRPGAuthorizationLoginResponseCharacter] = self.character;
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  NSDictionary *character = [aDictionary[kRPGAuthorizationLoginResponseCharacter] firstObject];
  return [self initWithUsername:aDictionary[kRPGAuthorizationLoginResponseUsername]
                          token:aDictionary[kRPGAuthorizationLoginResponseToken]
                         avatar:aDictionary[kRPGAuthorizationLoginResponseAvatar]
                           gold:[aDictionary[kRPGAuthorizationLoginResponseGold] integerValue]
                       crystals:[aDictionary[kRPGAuthorizationLoginResponseCrystals] integerValue]
                      character:character
                         status:[aDictionary[kRPGAuthorizationLoginResponseStatus] integerValue]];
}


@end
