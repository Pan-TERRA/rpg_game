//
//  RPGBasicNetworkResponse.h
//  RPG Game
//
//  Created by Степан Супинский on 11/18/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPGBasicNetworkResponse : NSObject

@property (assign, nonatomic, readonly) NSInteger status;

- (instancetype)initWithStatus:(NSInteger)aStatus NS_DESIGNATED_INITIALIZER;
+ (instancetype)requestWithStatus:(NSInteger)aStatus;

@end
