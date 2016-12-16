//
//  RPGResponse.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
  // Misc
#import "RPGSerializable.h"
  // Constants
#import "RPGStatusCodes.h"

extern NSString * const kRPGResponseSerializationType;
extern NSString * const kRPGResponseSerializationStatus;

/**
 *  Basic response class. Mainly used by "RPGBattleController".
 */
@interface RPGResponse : NSObject <RPGSerializable>

@property (nonatomic, copy, readonly) NSString *type;
@property (nonatomic, assign, readonly) RPGStatusCode status;

#pragma mark - Init

- (instancetype)initWithType:(NSString *)aType
                      status:(RPGStatusCode)aStatus NS_DESIGNATED_INITIALIZER;
+ (instancetype)responseWithType:(NSString *)aType
                          status:(RPGStatusCode)aStatus;

@end
