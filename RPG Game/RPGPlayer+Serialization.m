//
//  RPGPlayer+Serialization.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGPlayer+Serialization.h"
#import "RPGEntity+Serialization.h"

NSString * const kRPGPlayerSkills = @"skills";

@interface RPGPlayer ()

@property (retain, nonatomic, readwrite) NSArray<NSNumber *> *skills;

@end

@implementation RPGPlayer (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [[super dictionaryRepresentation] mutableCopy];

  dictionaryRepresentation[kRPGPlayerSkills] = self.skills;
  
  return [dictionaryRepresentation autorelease];
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  self = [super initWithDictionaryRepresentation:aDictionary];
  self.skills = aDictionary[kRPGPlayerSkills];
  return self;
}


@end
