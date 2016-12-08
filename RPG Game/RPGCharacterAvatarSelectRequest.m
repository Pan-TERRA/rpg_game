//
//  RPGChooseAvatarRequest.m
//  RPG Game
//
//  Created by Максим Шульга on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGCharacterAvatarSelectRequest.h"

NSString * const kRPGCharacterAvatarSelectRequestAvatarID = @"avatar_id";

@interface RPGCharacterAvatarSelectRequest()

@property (nonatomic, assign, readwrite) NSInteger avatarID;

@end

@implementation RPGCharacterAvatarSelectRequest

#pragma mark - Init

- (instancetype)initWithAvatarID:(NSInteger)anAvatarID
{
  self = [super init];
  
  if (self != nil)
  {
    if (anAvatarID >= 1)
    {
      _avatarID = anAvatarID;
    }
    else
    {
      [self release];
      self = nil;
    }
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithAvatarID:0];
}

+ (instancetype)characterAvatarSelectRequestWithAvatarID:(NSInteger)anAvatarID
{
  return [[[self alloc] initWithAvatarID:anAvatarID] autorelease];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [super dealloc];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
  
  dictionary[kRPGCharacterAvatarSelectRequestAvatarID] = @(self.avatarID);
  
  return dictionary;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithAvatarID:[aDictionary[kRPGCharacterAvatarSelectRequestAvatarID] integerValue]];
}

@end
