//
//  RPGClassInfoRepresentation.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/23/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPGClassInfoRepresentation : NSObject

@property (assign, readonly, nonatomic) NSArray<NSString *> *classNames;

- (NSInteger)classIDByName:(NSString *)aClassName;

@end
