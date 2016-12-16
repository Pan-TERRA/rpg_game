//
//  RPGAddFriendRequest.m
//  RPG Game
//
//  Created by Владислав Крут on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAddFriendRequest.h"

NSString * const kRPGAddFriendRequestUserName = @"username";

@interface RPGAddFriendRequest()

@property (nonatomic, copy, readwrite) NSString *userName;

@end

@implementation RPGAddFriendRequest

#pragma mark - Init

- (instancetype)initWithUserName:(NSString *)anUserName
{
  self = [super init];
  
  if (self != nil)
  {
    _userName = [anUserName copy];
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithUserName:nil];
}

+ (instancetype)addFriendRequestWithUserName:(NSString *)anUserName
{
  return [[[self alloc] initWithUserName:anUserName] autorelease];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_userName release];
  
  [super dealloc];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGAddFriendRequestUserName] = self.userName;
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithUserName:aDictionary[kRPGAddFriendRequestUserName]];
}

@end
