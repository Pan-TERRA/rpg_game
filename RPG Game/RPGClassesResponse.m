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

@implementation RPGClassesResponse

#pragma mark - Init

- (instancetype)init
{
  return [self initWithStatus:-1 classes:nil];
}

- (instancetype)initWithStatus:(NSInteger)status classes:(NSArray *)classes
{
  self = [super init];
  if (self != nil)
  {
    _status = status;
    if (classes != nil)
    {
    _classes = [[NSArray alloc] initWithArray:classes];
    }
    else
    {
      _classes = [[NSArray alloc] init];
    }
  }
  
  return self;
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
  dictionary[kRPGClassesResposeClasses] = self.classes;
  
  return dictionary;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithStatus:[aDictionary[kRPGClassesResposeStatus] integerValue]
                      classes:aDictionary[kRPGClassesResposeClasses]];
}

@end
