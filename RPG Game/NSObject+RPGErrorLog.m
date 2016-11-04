//
//  NSObject+RPGErrorLog.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/4/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "NSObject+RPGErrorLog.h"

@implementation NSObject (RPGErrorLog)

- (void)logError:(NSError *)anError withTitle:(NSString *)aTitle
{
  NSLog(@"%s", __PRETTY_FUNCTION__);
  
  NSLog(@"%@", aTitle);
  NSLog(@"Domain: %@", anError.domain);
  NSLog(@"Error Code: %ld", anError.code);
  NSLog(@"Description: %@", [anError localizedDescription]);
  NSLog(@"Reason: %@", [anError localizedFailureReason]);
}

@end
