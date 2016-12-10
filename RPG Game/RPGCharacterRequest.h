//
//  RPGCharacterRequest.h
//  RPG Game
//
//  Created by Максим Шульга on 11/17/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
  // Misc
#import "RPGSerializable.h"

extern NSString * const kRPGCharacterRequestCharacterID;

@interface RPGCharacterRequest : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) NSInteger characterID;

- (instancetype)initWithCharacterID:(NSInteger)aCharacterID NS_DESIGNATED_INITIALIZER;
+ (instancetype)characterRequestWithCharacterID:(NSInteger)aCharacterID;

@end
