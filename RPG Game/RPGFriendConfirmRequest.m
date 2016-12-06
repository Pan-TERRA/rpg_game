//
//  RPGFriendConfirmRequest.m
//  RPG Game
//
//  Created by Владислав Крут on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGFriendConfirmRequest.h"

NSString * const kRPGFriendConfirmRequestResult = @"result";

@interface RPGFriendConfirmRequest()

@property (nonatomic, assign, readwrite) BOOL result;

@end

@implementation RPGFriendConfirmRequest

#pragma mark - Init

- (instancetype)initWithFriendID:(NSInteger)aFriendID
                          result:(BOOL)aResult
{
  self = [super initWithFriendID:aFriendID];
  
  if (self != nil)
  {
    _result = aResult;
  }
  
  return self;
}

- (instancetype)initWithFriendID:(NSInteger)aFriendID
{
  return [self initWithFriendID:-1 result:NO];
}

- (instancetype)init
{
  return [self initWithFriendID:-1 result:NO];
}

+ (instancetype)friendConfirmRequestWithFriendID:(NSInteger)aFriendID
                                          result:(BOOL)aResult
{
  return [[[self alloc] initWithFriendID:aFriendID result:aResult] autorelease];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [super dealloc];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [[super dictionaryRepresentation] mutableCopy];
  
  dictionaryRepresentation[kRPGFriendConfirmRequestResult] = @(self.result);
  
  return [dictionaryRepresentation autorelease];
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithFriendID:[aDictionary[kRPGFriendRequestFriendID] integerValue]
                         result:[aDictionary[kRPGFriendConfirmRequestResult] boolValue]];
}

@end
