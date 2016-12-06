//
//  RPGClassesResponse.m
//  RPG Game
//
//  Created by Степан Супинский on 10/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGClassesResponse.h"

static NSString * const kRPGClassesResposeStatus = @"status";
static NSString * const kRPGClassesResposeClasses = @"classes";

@interface RPGClassesResponse()

@property (nonatomic, assign, readwrite) NSInteger status;
@property (nonatomic, retain, readwrite) NSArray *classes;

@end

@implementation RPGClassesResponse

#pragma mark - Init

- (instancetype)initWithStatus:(NSInteger)aStatus
                       classes:(NSArray *)aClasses
{
  self = [super init];
  if (self != nil)
  {
    _status = aStatus;
    if (aClasses != nil)
    {
    _classes = [aClasses retain];
    }
    else
    {
      _classes = [[NSArray alloc] init];
    }
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithStatus:-1
                      classes:nil];
}

+ (instancetype)responseWithStatus:(NSInteger)aStatus
                           classes:(NSArray *)aClasses
{
  return [[[self alloc] initWithStatus:aStatus
                               classes:aClasses] autorelease];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_classes release];
  
  [super dealloc];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
  
  dictionary[kRPGClassesResposeStatus] = @(self.status);
  
  if (self.classes != nil)
  {
    dictionary[kRPGClassesResposeClasses] = self.classes;
  }
  
  return dictionary;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithStatus:[aDictionary[kRPGClassesResposeStatus] integerValue]
                      classes:aDictionary[kRPGClassesResposeClasses]];
}

@end
