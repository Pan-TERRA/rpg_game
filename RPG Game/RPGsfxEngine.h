//
//  RPGsfxEngine.h
//  RPG Game
//
//  Created by Владислав Крут on 10/14/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPGSFXEngine : NSObject

@property (nonatomic, assign) BOOL state;

+ (instancetype)sharedSFXEngine;

- (void)playSFXNamed:(NSString *)name;
- (void)playSFXWithSpellID:(NSUInteger)identifier;

- (void)changeVolume:(double)volume;
- (double)getVolume;
- (void)toggle:(BOOL)state;

@end
