//
//  RPGShopCollectionViewCell.m
//  RPG Game
//
//  Created by Владислав Крут on 11/23/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGShopCollectionViewCell.h"
  // Entities
#import "RPGShopUnitRepresetation.h"
#import "RPGSkillRepresentation.h"

@interface RPGShopCollectionViewCell ()

@property (nonatomic, assign, readwrite) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *unitImageView;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *buyButton;

@end

@implementation RPGShopCollectionViewCell

#pragma mark - Accessors

- (void)setShopUnit:(RPGShopUnitRepresetation *)aShopUnit
{
  if (_shopUnit != aShopUnit)
  {
    _shopUnit = aShopUnit;
    
    self.unitImageView.image = [UIImage imageNamed:aShopUnit.imageName];
    
    UIImage *priceTypeImage = nil;
    
    if (aShopUnit.priceType == kRPGShopUnitPriceTypeCrystals)
    {
      priceTypeImage = [UIImage imageNamed:@"Ruby"];
    }
    else
    {
      priceTypeImage = [UIImage imageNamed:@"Gold"];
    }
    
    [self.buyButton setTitle:[@(aShopUnit.priceCount) stringValue] forState:UIControlStateNormal];
    [self.buyButton setImage:priceTypeImage forState:UIControlStateNormal];
  
    self.titleLabel.text = [NSString stringWithFormat:@"%@ (%ld)", aShopUnit.shopUnitName, (long)aShopUnit.unitCount];
  }
}

- (IBAction)buyAction:(UIButton *)sender
{
  [self.delegate buyButtonDidPressOnCell:self];
}

@end
