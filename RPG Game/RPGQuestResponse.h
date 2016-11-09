//
//  RPGQuestResponse.h
//  RPG Game
//
//  Created by Максим Шульга on 10/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGSerializable.h"

@interface RPGQuestResponse : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) NSInteger status;

- (instancetype)initWithStatus:(NSInteger)aStatus NS_DESIGNATED_INITIALIZER;
+ (instancetype)questResponseWithStatus:(NSInteger)aStatus;

@end
