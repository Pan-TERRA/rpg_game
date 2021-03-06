//
//  RPGResourcesResponse.h
//  RPG Game
//
//  Created by Максим Шульга on 11/8/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
  // Misc
#import "RPGSerializable.h"
  // Entities
@class RPGResources;
  // Constants
#import "RPGStatusCodes.h"

@interface RPGResourcesResponse : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) RPGStatusCode status;
@property (nonatomic, retain, readonly) RPGResources *resources;

- (instancetype)initWithStatus:(RPGStatusCode)aStatus
                     resources:(RPGResources *)aResources NS_DESIGNATED_INITIALIZER;
+ (instancetype)responseWithStatus:(RPGStatusCode)aStatus
                         resources:(RPGResources *)aResources;

@end
