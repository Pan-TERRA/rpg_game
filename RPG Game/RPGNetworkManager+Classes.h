//
//  RPGNetworkManager+Classes.h
//  RPG Game
//
//  Created by Степан Супинский on 10/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager.h"

@interface RPGNetworkManager (Classes)

- (void)fetchClassesWithCompletionHandler:(void (^)(NSInteger status, NSArray *classes))callbackBlock;
- (void)getClassInfoByID:(NSInteger)ID completionHandler:(void (^)(NSInteger status, NSDictionary *skillInfo))callbackBlock;

@end
