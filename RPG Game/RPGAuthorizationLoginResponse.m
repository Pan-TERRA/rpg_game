//
//  RPGAuthorizationLoginResponse.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAuthorizationLoginResponse.h"

@interface RPGAuthorizationLoginResponse ()

@property (nonatomic, assign, readwrite) NSInteger status;
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
                          status:(NSInteger)aStatus
{
  self = [super init];
  
  if (self != nil)
  {
    if (aUsername == nil ||
        aToken == nil ||
        anAvatar == nil ||
        aGold < 0 ||
        aCrystals < 0 ||
        aCharacters == nil)
    {
      [self release];
      self = nil;
    }
    else
    {
      _status = aStatus;
      _username = [aUsername copy];
      _token = [aToken copy];
      _avatar = [anAvatar copy];
      _gold = aGold;
      _crystals = aCrystals;
      _characters = [aCharacters retain];
    }
  }
  
  return self;
}

+ (instancetype)responseWithUsername:(NSString *)aUsername
                               token:(NSString *)aToken
                              avatar:(NSString *)anAvatar
                                gold:(NSInteger)aGold
                            crystals:(NSInteger)aCrystals
                          characters:(NSArray *)aCharacters
                              status:(NSInteger)aStatus
{
  return [[[self alloc] initWithUsername:aUsername
                                   token:aToken
                                  avatar:anAvatar
                                    gold:aGold
                                crystals:aCrystals
                              characters:aCharacters
                                  status:aStatus] autorelease];
}

- (instancetype)init
{
  return [self initWithUsername:nil
                          token:nil
                         avatar:nil
                           gold:-1
                       crystals:-1
                     characters:nil
                         status:-1];
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


@end
