//
//  RPGClassInfoRepresentation.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/23/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGClassInfoRepresentation.h"

static NSString * const kRPGClassInfoRepresentationResourcePath = @"RPGClassInfo";
static NSString * const kRPGClassInfoRepresentationResourceKeyID = @"id";
//static NSString * const kRPGClassInfoRepresentationResourceKeyDescription = @"description";

@interface RPGClassInfoRepresentation ()

@property (nonatomic, readwrite, retain) NSDictionary *classInfoDictionary;

@end

@implementation RPGClassInfoRepresentation

- (instancetype)init
{
  self = [super init];
  
  if (self != nil)
  {
    NSString *path = [[NSBundle mainBundle] pathForResource:kRPGClassInfoRepresentationResourcePath
                                                     ofType:@"plist"];
    _classInfoDictionary = [[NSDictionary dictionaryWithContentsOfFile:path] retain];
  }
  
  return self;
}

- (NSArray<NSString *> *)classNames
{
  return [self.classInfoDictionary allKeys];
}

- (NSInteger)classIDByName:(NSString *)aClassName
{
  return [self.classInfoDictionary[aClassName][kRPGClassInfoRepresentationResourceKeyID] integerValue];
}

@end
