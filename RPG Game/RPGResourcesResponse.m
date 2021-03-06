//
//  RPGResourcesResponse.m
//  RPG Game
//
//  Created by Максим Шульга on 11/8/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGResourcesResponse.h"
  // Entities
#import "RPGResources.h"

static NSString * const kRPGResourcesResponseStatus = @"status";
static NSString * const kRPGResourcesResponseResources = @"resources";

@interface RPGResourcesResponse ()

@property (nonatomic, assign, readwrite) RPGStatusCode status;
@property (nonatomic, retain, readwrite) RPGResources *resources;

@end

@implementation RPGResourcesResponse

#pragma mark - Init

- (instancetype)initWithStatus:(RPGStatusCode)aStatus
                     resources:(RPGResources *)aResources
{
  self = [super init];
  
  if (self != nil)
  {
    if (aStatus == kRPGStatusCodeOK && aResources == nil)
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

+ (instancetype)responseWithStatus:(RPGStatusCode)aStatus
                         resources:(RPGResources *)aResources
{
  return [[[self alloc] initWithStatus:aStatus
                             resources:aResources] autorelease];
}

- (instancetype)init
{
  return [self initWithStatus:-1
                    resources:nil];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_resources release];
  
  [super dealloc];
}

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  dictionaryRepresentation[kRPGResourcesResponseStatus] = @(self.status);
  
  if (self.resources != nil)
  {
    dictionaryRepresentation[kRPGResourcesResponseResources] = [self.resources dictionaryRepresentation];
  }
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  RPGResources *resources = [[[RPGResources alloc] initWithDictionaryRepresentation:aDictionary[kRPGResourcesResponseResources]] autorelease];
  
  return [self initWithStatus:[aDictionary[kRPGResourcesResponseStatus] integerValue]
                    resources:resources];
}

@end
