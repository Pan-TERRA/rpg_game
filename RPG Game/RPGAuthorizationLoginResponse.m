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
static NSString * const kRPGAuthorizationLoginResponseCharacter = @"characters";

@interface RPGAuthorizationLoginResponse ()

@property (nonatomic, assign, readwrite) RPGStatusCode status;
@property (nonatomic, copy, readwrite) NSString *username;
@property (nonatomic, copy, readwrite) NSString *token;
@property (nonatomic, retain, readwrite) NSDictionary *character;

@end

@implementation RPGAuthorizationLoginResponse

#pragma mark - Init

- (instancetype)initWithUsername:(NSString *)aUsername
                           token:(NSString *)aToken
                       character:(NSDictionary *)aCharacter
                          status:(RPGStatusCode)aStatus
{
  self = [super init];
  
  if (self != nil)
  {
    if (aUsername == nil ||
        aToken == nil ||
        aCharacter == nil)
    {
      [self release];
      self = nil;
    }
    else if (aUsername == nil
             || aToken == nil
             || aCharacter == nil)
    {
      _status = aStatus;
      _username = nil;
      _token = nil;
      
      _character = nil;
    }
    else
    {
      _status = aStatus;
      _username = [aUsername copy];
      _token = [aToken copy];
      _character = [aCharacter retain];
    }
  }
  
  return self;
}

+ (instancetype)responseWithUsername:(NSString *)aUsername
                               token:(NSString *)aToken
                           character:(NSDictionary *)aCharacter
                              status:(RPGStatusCode)aStatus
{
  return [[[self alloc] initWithUsername:aUsername
                                   token:aToken
                               character:aCharacter
                                  status:aStatus] autorelease];
}

- (instancetype)init
{
  return [self initWithUsername:nil
                          token:nil
                      character:nil
                         status:0];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_username release];
  [_token release];
  [_character release];
  
  [super dealloc];
}

#pragma mark - Actions

- (void)store
{
  NSUserDefaults *standartUserDefaults = [NSUserDefaults standardUserDefaults];
  standartUserDefaults.sessionToken = self.token;
  standartUserDefaults.sessionUsername = self.username;
    // TODO: characters array instead of one character
  standartUserDefaults.sessionCharacters = [NSArray arrayWithObject:self.character];
}

#pragma mark - RPGSerialization

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGAuthorizationLoginResponseStatus] = @(self.status);
  if (self.username != nil)
  {
    dictionaryRepresentation[kRPGAuthorizationLoginResponseUsername] = self.username;
  }
  if (self.token != nil)
  {
    dictionaryRepresentation[kRPGAuthorizationLoginResponseToken] = self.token;
  }
  if (self.character != nil)
  {
    dictionaryRepresentation[kRPGAuthorizationLoginResponseCharacter] = self.character;
  }
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  NSDictionary *character = [aDictionary[kRPGAuthorizationLoginResponseCharacter] firstObject];
  return [self initWithUsername:aDictionary[kRPGAuthorizationLoginResponseUsername]
                          token:aDictionary[kRPGAuthorizationLoginResponseToken]
                      character:character
                         status:[aDictionary[kRPGAuthorizationLoginResponseStatus] integerValue]];
}

@end
