//
//  RPGLocationInfoResponse.h
//  RPG Game
//
//  Created by Степан Супинский on 12/12/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
  // Misc
#import "RPGSerializable.h"
  // Constants
#import "RPGStatusCodes.h"

@interface RPGLocationInfoResponse : NSObject <RPGSerializable>

@property (readwrite, assign, nonatomic) RPGStatusCode status;
@property (readwrite, retain, nonatomic) NSArray<NSDictionary *> *locationInfo;

- (instancetype)initWithStatus:(RPGStatusCode)aStatus
                  locationInfo:(NSArray<NSDictionary *> *)aLocationInfo NS_DESIGNATED_INITIALIZER;


@end
