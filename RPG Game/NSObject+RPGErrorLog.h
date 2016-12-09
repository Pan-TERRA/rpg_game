//
//  NSObject+RPGErrorLog.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/4/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (RPGErrorLog)

- (void)logError:(NSError *)anError
       withTitle:(NSString *)aTitle;

@end
