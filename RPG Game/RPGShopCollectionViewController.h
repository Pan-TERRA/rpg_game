//
//  RPGShopCollectionViewController.h
//  RPG Game
//
//  Created by Владислав Крут on 11/23/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
  // Entity
@class RPGShopUnitRepresetation;
@class RPGShopCollectionViewController;

@protocol RPGShopCollectionViewControllerDelegate <NSObject>

- (void)buyButtonDidPress:(RPGShopCollectionViewController *)aCollectionViewController;

@end


@interface RPGShopCollectionViewController : UICollectionViewController

@property (nonatomic, retain, readwrite) NSArray<RPGShopUnitRepresetation *> *shopUnits;

@property (nonatomic, assign, readwrite) id<RPGShopCollectionViewControllerDelegate> delegate;



@end
