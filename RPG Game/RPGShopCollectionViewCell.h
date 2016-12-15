//
//  RPGShopCollectionViewCell.h
//  RPG Game
//
//  Created by Владислав Крут on 11/23/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

  // Entities
@class RPGShopUnitRepresetation;
  // Views
@class RPGShopCollectionViewCell;

@protocol RPGShopCollectionViewCellDelegate <NSObject>

- (void)buyButtonDidPressOnCell:(RPGShopCollectionViewCell *)aCell;

@end

@interface RPGShopCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign, readwrite) id<RPGShopCollectionViewCellDelegate> delegate;

@property (nonatomic, assign, readwrite) RPGShopUnitRepresetation *shopUnit;

@end
