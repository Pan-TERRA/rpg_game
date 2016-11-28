//
//  RPGArenaCollectionViewController.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGArenaCollectionViewController.h"

@implementation RPGArenaCollectionViewController

/**
 *  Swaps item to another collection.
 *  This method is invoked by superclass, when user taps a skill in collection
 *
 *  @param anItemID An item identifier
 *  @param aType    Type of an item
 */
- (void)moveItem:(NSUInteger)anItemID type:(RPGItemType)aType
{
  [self addItemToOtherCollectionWithID:anItemID type:aType];
}

@end
