//
//  RPGQuestRequest.m
//  RPG Game
//
//  Created by Максим Шульга on 10/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestRequest.h"

NSString * const kRPGQuestRequestQuestID = @"quest_id";

@interface RPGQuestRequest()

@property (nonatomic, assign, readwrite) NSUInteger questID;

@end

@implementation RPGQuestRequest

#pragma mark - Init

- (instancetype)initWithQuestID:(NSUInteger)aQuestID
{
  self = [super init];
  
  if (self != nil)
  {
    _questID = aQuestID;
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithQuestID:0];
}

+ (instancetype)questRequestWithQuestID:(NSUInteger)aQuestID
{
  return [[[self alloc] initWithQuestID:aQuestID] autorelease];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGQuestRequestQuestID] = @(self.questID);
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithQuestID:[aDictionary[kRPGQuestRequestQuestID] integerValue]];
}

@end
