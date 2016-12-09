//
//  RPGClassInfoResponse.h
//  RPG Game
//
//  Created by Степан Супинский on 10/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
  // Misc
#import "RPGSerializable.h"

@interface RPGClassInfoResponse : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) NSInteger status;
@property (nonatomic, retain, readonly) NSDictionary *classInfo;

- (instancetype)initWithStatus:(NSInteger)aStatus
                     classInfo:(NSDictionary *)aClassInfo NS_DESIGNATED_INITIALIZER;
+ (instancetype)responseWithStatus:(NSInteger)aStatus
                         classInfo:(NSDictionary *)aClassInfo;

@end
