//
//  RPGQuestRequest.h
//  RPG Game
//
//  Created by Максим Шульга on 10/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
  // Misc
#import "RPGSerializable.h"

extern NSString * const kRPGQuestRequestQuestID;

@interface RPGQuestRequest : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) NSInteger questID;

- (instancetype)initWithQuestID:(NSInteger)aQuestID NS_DESIGNATED_INITIALIZER;
+ (instancetype)questRequestWithQuestID:(NSInteger)aQuestID;

@end
