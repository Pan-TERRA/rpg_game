//
//  RPGAdventureGlobalMapViewController.m
//  RPG Game
//
//  Created by Степан Супинский on 12/1/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAdventureGlobalMapViewController.h"
  // Misc
#import "UIView+RPGColorOfPoint.h"
#import "UIColor+RPGColorEquality.h"
  // Constants
#import "RPGNibNames.h"

  // Global map location mask colors
#define GLOBAL_MAP_LOCATION1_MASK_COLOR [UIColor colorWithRed:0.32549 green:0.219608 blue:0.113725 alpha:1.0]
#define GLOBAL_MAP_LOCATION2_MASK_COLOR [UIColor colorWithRed:0.647059 green:0.411765 blue:0.411765 alpha:1.0]
#define GLOBAL_MAP_LOCATION3_MASK_COLOR [UIColor colorWithRed:0.266667 green:0.945098 blue:0.00392157 alpha:1.0]
#define GLOBAL_MAP_LOCATION4_MASK_COLOR [UIColor colorWithRed:0.27451 green:0.235294 blue:0.752941 alpha:1.0]

@interface RPGAdventureGlobalMapViewController ()

#pragma - Outlets

  // View outlets
@property (readwrite, assign, nonatomic) IBOutlet UIImageView *maskImageView;
@property (readwrite, assign, nonatomic) IBOutlet UIImageView *displayImageView;
  // Constraint outlets
@property (readwrite, assign, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidthConstraint;
@property (readwrite, assign, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightConstraint;

@end

@implementation RPGAdventureGlobalMapViewController

#pragma mark Init

- (instancetype)init
{
  return [self initWithNibName:kRPGAdventureGlobalMapViewControllerNIBName bundle:nil];
}

#pragma mark - UIViewController

- (void)viewDidLayoutSubviews
{
  self.contentViewWidthConstraint.constant = self.maskImageView.frame.size.width;
  self.contentViewHeightConstraint.constant = self.maskImageView.frame.size.height;
}

#pragma mark - Map

- (IBAction)mapTappedAction:(UITapGestureRecognizer *)gestureRecognizer
{
  CGPoint tapLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
  UIColor *tappedLocationColor = [self.maskImageView colorOfPoint:tapLocation];
  NSInteger tappedLocationID = [self getMapLocationIDWithColor:tappedLocationColor];

  NSLog(@"%ld", tappedLocationID);
}

- (NSInteger)getMapLocationIDWithColor:(UIColor *)aColor
{
  NSInteger result = -1;
  NSArray<UIColor *> *mapLocationColors = @[
                                 GLOBAL_MAP_LOCATION1_MASK_COLOR,
                                 GLOBAL_MAP_LOCATION2_MASK_COLOR,
                                 GLOBAL_MAP_LOCATION3_MASK_COLOR,
                                 GLOBAL_MAP_LOCATION4_MASK_COLOR
                                 ];
  for (NSInteger i = 0; i < mapLocationColors.count; i++)
  {
    if ([aColor isEqualToColor:mapLocationColors[i]])
    {
      result = i + 1;
    }
  }
  
  return result;
}

@end
