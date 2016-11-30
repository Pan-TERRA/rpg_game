//
//  RPGConfirmQuestChallengeRequest.m
//  RPG Game
//
//  Created by Владислав Крут on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGConfirmChallengeRequest.h"

NSString * const kRPGConfirmChallengeRequestQuestID = @"friend_id";
NSString * const kRPGConfirmChallengeRequestResult = @"result";

@interface RPGConfirmChallengeRequest()

@property (nonatomic, assign, readwrite) NSInteger friendID;
@property (nonatomic, assign, readwrite) BOOL result;

@end

@implementation RPGConfirmChallengeRequest

#pragma mark - Init

- (instancetype)initWithFriendID:(NSInteger)aFriendID
                          result:(BOOL)aResult
{
  self = [super init];
  
  if (self != nil)
  {
    _friendID = aFriendID;
    _result = aResult;
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithFriendID:-1 result:NO];
}

+ (instancetype)confirmChallengeRequestWithFriendID:(NSInteger)aFriendID
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
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGConfirmChallengeRequestQuestID] = @(self.friendID);
  dictionaryRepresentation[kRPGConfirmChallengeRequestResult] = @(self.result);
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithFriendID:[aDictionary[kRPGConfirmChallengeRequestQuestID] integerValue]
                         result:[aDictionary[kRPGConfirmChallengeRequestResult] boolValue]];
}

@end
