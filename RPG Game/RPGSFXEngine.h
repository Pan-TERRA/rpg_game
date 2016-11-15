//
//  RPGsfxEngine.h
//  RPG Game
//
//  Created by Владислав Крут on 10/14/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPGSFXEngine : NSObject

@property (nonatomic, assign, readwrite, getter=isPlaying) BOOL playing;
@property (nonatomic, assign, readwrite) double volume;

+ (instancetype)sharedSFXEngine;

#pragma mark - API

- (void)playSFXNamed:(NSString *)name;
- (void)playSFXWithSpellID:(NSUInteger)identifier;

@end
