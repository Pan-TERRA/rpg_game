//
//  RPGRegistrationRequest.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 10/14/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGRegistrationRequest.h"

@interface RPGRegistrationRequest ()

@property (copy, nonatomic, readwrite) NSString *email;
@property (copy, nonatomic, readwrite) NSString *password;
@property (copy, nonatomic, readwrite) NSString *characterName;
@property (readwrite) NSInteger characterType;

@end

@implementation RPGRegistrationRequest

#pragma mark - Init

- (instancetype)initWithEmail:(NSString *)anEmail
                     password:(NSString *)aPassword
                characterName:(NSString *)aCharacterName
                characterType:(NSInteger)aCharacterType
{
  self = [super init];
  
  if (aCharacterType < 0 ||
      anEmail == nil ||
      aPassword == nil ||
      aCharacterName == nil)
  {
    [self release];
    self = nil;
  }
  
  if (self != nil)
  {
    _email = [anEmail copy];
    _password = [aPassword copy];
    _characterName = [aCharacterName copy];
    _characterType = aCharacterType;
  }
  
  return self;
}

+ (instancetype)registrationRequestWithEmail:(NSString *)anEmail
                                    password:(NSString *)aPassword
                               characterName:(NSString *)aCharacterName
                               characterType:(NSInteger)aCharacterType
{
  return [[[self alloc] initWithEmail:anEmail password:aPassword characterName:aCharacterName characterType:aCharacterType] autorelease];
}

- (instancetype)init
{
  return [self initWithEmail:nil password:nil characterName:nil characterType:-1];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_email release];
  [_password release];
  [_characterName release];
  
  [super dealloc];
}

@end
