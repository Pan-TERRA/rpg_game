  //
  //  RPGRegistrationRequest.m
  //  RPG Game
  //
  //  Created by Костянтин Паляничко on 10/14/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGRegistrationRequest.h"

@interface RPGRegistrationRequest ()

@property (nonatomic, copy, readwrite) NSString *username;
@property (nonatomic, copy, readwrite) NSString *email;
@property (nonatomic, copy, readwrite) NSString *password;
@property (nonatomic, copy, readwrite) NSString *characterName;
@property (nonatomic, assign, readwrite) NSInteger characterType;

@end

@implementation RPGRegistrationRequest

#pragma mark - Init

- (instancetype)initWithEmail:(NSString *)anEmail
                     password:(NSString *)aPassword
                     username:(NSString *)aUsername
                characterName:(NSString *)aCharacterName
                characterType:(NSInteger)aCharacterType
{
  self = [super init];
  
  if (aCharacterType < 0 ||
      anEmail == nil ||
      aUsername == nil ||
      aPassword == nil ||
      aCharacterName == nil)
  {
    [self release];
    self = nil;
  }
  
  if (self != nil)
  {
    _username = [aUsername copy];
    _email = [anEmail copy];
    _password = [aPassword copy];
    _characterName = [aCharacterName copy];
    _characterType = aCharacterType;
  }
  
  return self;
}

+ (instancetype)registrationRequestWithEmail:(NSString *)anEmail
                                    password:(NSString *)aPassword
                                    username:(NSString *)aUsername
                               characterName:(NSString *)aCharacterName
                               characterType:(NSInteger)aCharacterType
{
  return [[[self alloc] initWithEmail:anEmail
                             password:aPassword
                             username:aUsername
                        characterName:aCharacterName
                        characterType:aCharacterType] autorelease];
}

- (instancetype)init
{
  return [self initWithEmail:nil
                    password:nil
                    username:nil
               characterName:nil
               characterType:-1];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_username release];
  [_email release];
  [_password release];
  [_characterName release];
  [super dealloc];
}

@end
