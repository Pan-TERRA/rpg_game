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

@interface RPGClassInfoResponse()

@property (nonatomic, assign, readwrite) NSInteger status;
@property (nonatomic, retain, readwrite) NSDictionary *classInfo;

@end

@implementation RPGClassInfoResponse

#pragma mark - Init

- (instancetype)initWithStatus:(NSInteger)aStatus
                     classInfo:(NSDictionary *)aClassInfo
{
  self = [super init];
  
  if (self != nil)
  {
    _status = aStatus;
    _classInfo = [aClassInfo retain];
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithStatus:-1
                    classInfo:nil];
}

+ (instancetype)responseWithStatus:(NSInteger)aStatus
                         classInfo:(NSDictionary *)aClassInfo
{
  return [[[self alloc] initWithStatus:aStatus
                             classInfo:aClassInfo] autorelease];
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
  NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
  
  dictionary[kRPGClassInfoResponseStatus] = @(self.status);
  
  if (self.classInfo != nil)
  {
    dictionary[kRPGClassInfoResponseClass] = self.classInfo;
  }
  
  return dictionary;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithStatus:[aDictionary[kRPGClassInfoResponseStatus] integerValue]
                    classInfo:aDictionary[kRPGClassInfoResponseClass]];
}

@end
