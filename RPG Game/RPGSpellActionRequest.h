//
//  RPGSpellCondtion.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGRequest.h"

extern NSString * const kRPGSpellActionRequestType;

@interface RPGSpellActionRequest : RPGRequest

@property (assign, nonatomic, readonly) NSInteger spellID;

- (instancetype)initWithSpellID:(NSInteger)aSpellID token:(NSString *)aToken NS_DESIGNATED_INITIALIZER;
+ (instancetype)requestWithSpellID:(NSInteger)aSpellID token:(NSString *)aToken;

@end
