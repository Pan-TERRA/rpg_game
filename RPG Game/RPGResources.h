//
//  RPGResources.h
//  RPG Game
//
//  Created by Максим Шульга on 11/8/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
  // Misc
#import "RPGSerializable.h"

extern NSString * const kRPGResourcesGold;
extern NSString * const kRPGResourcesCrystals;

@interface RPGResources : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) NSInteger gold;
@property (nonatomic, assign, readonly) NSInteger crystals;

- (instancetype)initWithGold:(NSInteger)aGold
                    crystals:(NSInteger)aCrystals NS_DESIGNATED_INITIALIZER;
+ (instancetype)resourcesWithGold:(NSInteger)aGold
                         crystals:(NSInteger)aCrystals;

@end
