//
//  RPGDuelCountResponse.h
//  RPG Game
//
//  Created by Максим Шульга on 12/15/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
  // Misc
#import "RPGSerializable.h"

@interface RPGDuelCountResponse : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) NSInteger status;
@property (nonatomic, assign, readonly) NSInteger duelQuestsCount;

- (instancetype)initWithStatus:(NSInteger)aStatus
               duelQuestsCount:(NSInteger)aCount NS_DESIGNATED_INITIALIZER;
+ (instancetype)duelCountResponseWithStatus:(NSInteger)aStatus
                            duelQuestsCount:(NSInteger)aCount;

@end
