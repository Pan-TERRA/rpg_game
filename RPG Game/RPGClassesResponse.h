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

@interface RPGClassesResponse : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) NSInteger status;
@property (nonatomic, retain, readonly) NSArray *classes;

- (instancetype)initWithStatus:(NSInteger)aStatus
                       classes:(NSArray *)aClasses NS_DESIGNATED_INITIALIZER;
+ (instancetype)responseWithStatus:(NSInteger)aStatus
                           classes:(NSArray *)aClasses;

@end
