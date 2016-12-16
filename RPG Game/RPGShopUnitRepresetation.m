//
//  RPGShopUnitRepresetation.m
//  RPG Game
//
//  Created by Владислав Крут on 12/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGShopUnitRepresetation.h"

static NSString * const sRPGShopUnitRepresentationDescription = @"description";
static NSString * const sRPGShopUnitRepresentationImageName = @"imageName";

@interface RPGShopUnitRepresetation ()

@property (nonatomic, assign, readwrite) NSInteger shopUnitID;
@property (nonatomic, copy, readwrite) NSString *shopUnitName;
@property (nonatomic, assign, readwrite) RPGShopUnitType unitType;
@property (nonatomic, assign, readwrite) NSInteger unitCount;
@property (nonatomic, assign, readwrite) RPGShopUnitPriceType priceType;
@property (nonatomic, assign, readwrite) NSInteger priceCount;
@property (nonatomic, assign, readwrite) NSInteger skillID;

@property (nonatomic, copy, readwrite) NSString *shopUnitDescription;
@property (nonatomic, copy, readwrite) NSString *imageName;

@end


@implementation RPGShopUnitRepresetation

#pragma mark - Init

- (instancetype)initWithShopUnit:(RPGShopUnit *)aShopUnit
{
  self = [super init];
  
  if (self != nil)
  {
    _shopUnitID = aShopUnit.unitID;
    _shopUnitName = [aShopUnit.unitName copy];
    _unitType = aShopUnit.unitType;
    _unitCount = aShopUnit.unitCount;
    _priceType = aShopUnit.priceType;
    _priceCount = aShopUnit.priceCount;
    _skillID = aShopUnit.skillID;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"RPGShopUnitsInfo" ofType:@"plist"];
    NSDictionary *plistDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    NSDictionary *shopUnitDictionary = [plistDictionary valueForKey:[@(aShopUnit.unitID) stringValue]];
    
    _shopUnitDescription = [shopUnitDictionary[sRPGShopUnitRepresentationDescription] copy];
    _imageName = [shopUnitDictionary[sRPGShopUnitRepresentationImageName] copy];
  }
  
  return self;
}

+ (instancetype)shopUnitRepresetationWithShopUnit:(RPGShopUnit *)aShopUnit
{
  return [[[self alloc] initWithShopUnit:aShopUnit] autorelease];
}

- (instancetype)init
{
  return [self initWithShopUnit:nil];
}

- (void)dealloc
{
  [_shopUnitName release];
  [_shopUnitDescription release];
  [_imageName release];
  
  [super dealloc];
}

@end
