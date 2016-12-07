//
//  RPGClassInfoResponse.m
//  RPG Game
//
//  Created by Степан Супинский on 10/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGClassInfoResponse.h"

static NSString * const kRPGClassInfoResponseStatus = @"status";
static NSString * const kRPGClassInfoResponseClass = @"class";

@implementation RPGClassInfoResponse

#pragma mark - Init

- (instancetype)initWithStatus:(NSInteger)aStatus classInfo:(NSDictionary *)aClassInfo
{
  self = [super init];
  if (self != nil)
  {
    _status = aStatus;
    _classInfo = [[NSDictionary alloc] initWithDictionary:aClassInfo];
  }
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_classInfo release];
  [super dealloc];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  return @{
           kRPGClassInfoResponseStatus: @(self.status),
           kRPGClassInfoResponseClass: self.classInfo
           };
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithStatus:[aDictionary[kRPGClassInfoResponseStatus] integerValue]
                    classInfo:aDictionary[kRPGClassInfoResponseClass]];
}

@end
