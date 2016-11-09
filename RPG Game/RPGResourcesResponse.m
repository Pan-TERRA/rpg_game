//
//  RPGResourcesResponse.m
//  RPG Game
//
//  Created by Максим Шульга on 11/8/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGResourcesResponse.h"

@interface RPGResourcesResponse ()

@property (nonatomic, assign, readwrite) NSInteger status;
@property (nonatomic, retain, readwrite) RPGResources *resources;

@end

@implementation RPGResourcesResponse

#pragma mark - Init

- (instancetype)initWithStatus:(NSInteger)aStatus
                     resources:(RPGResources *)aResources
{
  self = [super init];
  
  if (self != nil)
  {
    if (aStatus == 0 && aResources == nil)
    {
      [self release];
      self = nil;
    }
    else if (aStatus != 0 && aResources == nil)
    {
      _resources = nil;
    }
    else
    {
      _status = aStatus;
      _resources = [aResources retain];
    }
  }
  
  return self;
}

+ (instancetype)responseWithStatus:(NSInteger)aStatus
                         resources:(RPGResources *)aResources
{
  return [[[self alloc] initWithStatus:aStatus
                             resources:aResources] autorelease];
}

- (instancetype)init
{
  return [self initWithStatus:0
                    resources:nil];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_resources release];
  [super dealloc];
}

@end

