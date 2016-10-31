//
//  RPGClassInfoResponse.h
//  RPG Game
//
//  Created by Степан Супинский on 10/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPGClassInfoResponse : NSObject

@property (assign, nonatomic, readwrite) NSInteger status;
@property (copy, nonatomic, readwrite) NSDictionary *classInfo;

- (instancetype)initWithStatus:(NSInteger)status classInfo:(NSDictionary *)classInfo;

@end
