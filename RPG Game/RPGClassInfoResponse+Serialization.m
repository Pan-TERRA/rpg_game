//
//  RPGClassInfoResponse+Serialization.m
//  RPG Game
//
//  Created by Степан Супинский on 10/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGClassInfoResponse+Serialization.h"

static NSString * const kRPGClassInfoResponseStatus = @"status";
static NSString * const kRPGClassInfoResponseClass = @"class";

@implementation RPGClassInfoResponse (Serialization)

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
