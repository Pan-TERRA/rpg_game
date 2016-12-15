//
//  RPGClassesResponse.h
//  RPG Game
//
//  Created by Степан Супинский on 10/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
  // Misc
#import "RPGSerializable.h"
  // Constants
#import "RPGStatusCodes.h"

@interface RPGClassesResponse : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) RPGStatusCode status;
@property (nonatomic, retain, readonly) NSArray<NSDictionary *> *classes;

- (instancetype)initWithStatus:(RPGStatusCode)aStatus
                       classes:(NSArray<NSDictionary *> *)aClasses NS_DESIGNATED_INITIALIZER;
+ (instancetype)responseWithStatus:(RPGStatusCode)aStatus
                           classes:(NSArray<NSDictionary *> *)aClasses;

@end
