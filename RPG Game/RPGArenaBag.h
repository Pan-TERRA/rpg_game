//
//  RPGArenaBag.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/20/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const NSUInteger kRPGArenaBagSetSize;

@interface RPGArenaBag : NSObject

- (instancetype)initWithArray:(NSArray<NSNumber *> *)anArray;

/**
 *  Extract next random kRPGArenaBagSetSize items from bag.
 *  Returns nil if bag is already empty.
 */
- (NSArray<NSNumber *> *)getNextRandomItems;

@end
