//
//  RPGsfxEngine.h
//  RPG Game
//
//  Created by Владислав Крут on 10/14/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPGSFXEngine : NSObject

+ (instancetype)sharedSFXEngine;

- (void)playSFXNamed:(NSString *)name;

@end
