//
//  RPGShopCollectionViewCell.m
//  RPG Game
//
//  Created by Владислав Крут on 11/23/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGShopCollectionViewCell.h"
  // Entities
#import "RPGShopUnit.h"
#import "RPGSkillRepresentation.h"

@interface RPGShopCollectionViewCell ()

@property (nonatomic, assign, readwrite) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *unitImageView;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *buyButton;

@end

@implementation RPGShopCollectionViewCell

#pragma mark - Dealloc

- (void)dealloc
{
  [_shopUnit release];
  
  [super dealloc];
}

#pragma mark - Accessors

- (void)setShopUnit:(RPGShopUnit *)aShopUnit
{
  if (_shopUnit != aShopUnit)
  {
    _shopUnit = aShopUnit;
    
    //TODO: create plist for Shop Units
    UIImage *unitImage = nil;
    switch (aShopUnit.unitType)
    {
      case kRPGShopUnitTypeGold:
      {
        unitImage = [UIImage imageNamed:@"Gold"];
        
        break;
      }
        
      case kRPGShopUnitTypeSkill:
      {
        RPGSkillRepresentation *skillRepresentation = [RPGSkillRepresentation skillrepresentationWithSkillID:aShopUnit.skillID];
        unitImage = [UIImage imageNamed:skillRepresentation.imageName];
        
        if (unitImage == nil)
        {
          unitImage = [UIImage imageNamed:@"confirm_icon_inactive"];
        }
        
        break;
      }
        
      case kRPGShopUnitTypeBagSlot:
      {
        unitImage = [UIImage imageNamed:@"shop_icon"];
        
        break;
      }
        
      case kRPGShopUnitTypeActiveSlot:
      {
        unitImage = [UIImage imageNamed:@"hp_icon"];
        
        break;
      }
        
      default:
      {
        unitImage = [UIImage imageNamed:@"_967740272"];
        
        break;
      }
    }
    
    UIImage *priceTypeImage = nil;
    
    if (aShopUnit.priceType == kRPGShopUnitPriceTypeCrystals)
    {
      priceTypeImage = [UIImage imageNamed:@"Ruby"];
    }
    else
    {
      priceTypeImage = [UIImage imageNamed:@"Gold"];
    }
    
    self.unitImageView.image = unitImage;
    
    [self.buyButton setTitle:[@(aShopUnit.priceCount) stringValue] forState:UIControlStateNormal];
    [self.buyButton setImage:priceTypeImage forState:UIControlStateNormal];
  
    self.titleLabel.text = [NSString stringWithFormat:@"%@ (%ld)", aShopUnit.unitName, (long)aShopUnit.unitCount];
  }
}

- (IBAction)buyAction:(UIButton *)sender
{
  [self.delegate buyButtonDidPressOnCell:self];
}

@end
