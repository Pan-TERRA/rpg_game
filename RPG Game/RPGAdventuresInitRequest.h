//
//  RPGAdventuresInitRequest.h
//  RPG Game
//
//  Created by Степан Супинский on 12/12/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGRequest.h"

@interface RPGAdventuresInitRequest : RPGRequest

- (instancetype)initWithType:(NSString *)aType stageID:(NSInteger)aStageID NS_DESIGNATED_INITIALIZER;
+ (instancetype)requestWithType:(NSString *)aType stageID:(NSInteger)aStageID;

@property (readwrite, assign, nonatomic) NSInteger stageID;

@end
