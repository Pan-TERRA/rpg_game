//
//  RPGAdventureGlobalMapViewController.m
//  RPG Game
//
//  Created by Степан Супинский on 12/1/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAdventureGlobalMapViewController.h"
  // Controllers
#import "RPGLocationMapViewController.h"
  // Misc
#import "UIView+RPGColorOfPoint.h"
#import "UIColor+RPGColorEquality.h"
  // Constants
#import "RPGNibNames.h"

  // Global map location mask colors
#define GLOBAL_MAP_LOCATION1_MASK_COLOR [UIColor colorWithRed:0.776471 green:0.12549 blue:0.12549 alpha:1.0]
#define GLOBAL_MAP_LOCATION2_MASK_COLOR [UIColor colorWithRed:0.580392 green:0.105882 blue:0.984314 alpha:1.0]
#define GLOBAL_MAP_LOCATION3_MASK_COLOR [UIColor colorWithRed:0.976471 green:0.984314 blue:0.105882 alpha:1.0]
#define GLOBAL_MAP_LOCATION4_MASK_COLOR [UIColor colorWithRed:0.458824 green:0.717647 blue:0.184314 alpha:1.0]

@interface RPGAdventureGlobalMapViewController ()

  // View outlets
@property (readwrite, assign, nonatomic) IBOutlet UIImageView *maskImageView;
    // Lock outlets
@property (readwrite, assign, nonatomic) IBOutlet UIImageView *lock1;
@property (readwrite, assign, nonatomic) IBOutlet UIImageView *lock2;
@property (readwrite, assign, nonatomic) IBOutlet UIImageView *lock3;
@property (readwrite, assign, nonatomic) IBOutlet UIImageView *lock4;
@property (readwrite, assign, nonatomic) IBOutlet UIImageView *lock5;
@property (readwrite, assign, nonatomic) IBOutlet UIImageView *lock6;
@property (readwrite, assign, nonatomic) IBOutlet UIImageView *lock7;
@property (readwrite, assign, nonatomic) IBOutlet UIImageView *lock8;
@property (readwrite, assign, nonatomic) IBOutlet UIImageView *lock9;

// Propeties
@property (readwrite, retain, nonatomic) NSMutableArray<UIImageView *> *lockViews;

@end

@implementation RPGAdventureGlobalMapViewController

#pragma mark - Init

- (instancetype)init
{
  return [self initWithNibName:kRPGAdventureGlobalMapViewControllerNIBName bundle:nil];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_lockViews release];
  [super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.lockViews = [NSMutableArray arrayWithObjects:self.lock1, self.lock2,
                    self.lock3, self.lock4, self.lock4, self.lock5, self.lock6,
                    self.lock7, self.lock8, self.lock9, nil];
  
  for (UIImageView *lockImageView in self.lockViews)
  {
    if (lockImageView.tag == 1) //TODO: use API to find out what locations are enabled for current user
    {
      lockImageView.hidden = YES;
    }
  }
}

#pragma mark - IBActions

- (IBAction)backAction:(UIButton *)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Map

- (IBAction)mapTappedAction:(UITapGestureRecognizer *)gestureRecognizer
{
  CGPoint tapLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
  UIColor *tappedLocationColor = [self.maskImageView colorOfPoint:tapLocation];
  NSInteger tappedLocationID = [self getMapLocationIDWithColor:tappedLocationColor];
  
  RPGLocationMapViewController *locationMapViewController = [[[RPGLocationMapViewController alloc] initWithLocationID:tappedLocationID] autorelease];
  
  if (locationMapViewController != nil)
  {
    [self presentViewController:locationMapViewController
                       animated:YES
                     completion:nil];
  }

  NSLog(@"%ld", tappedLocationID);
}

- (NSInteger)getMapLocationIDWithColor:(UIColor *)aColor
{
  NSInteger result = -1;
  
  NSArray *mapLocationColors = [RPGAdventureGlobalMapViewController mapLocationColors];
  
  for (NSInteger i = 0; i < mapLocationColors.count; i++)
  {
    if ([aColor isEqualToColor:mapLocationColors[i]])
    {
      result = i + 1;
      break;
    }
  }
  
  return result;
}

#pragma mark - Constants

+ (NSArray<UIColor *> *)mapLocationColors
{
  static NSArray *mapLocationColors = nil;
  
  if (mapLocationColors == nil)
  {
    mapLocationColors = [[NSArray alloc] initWithObjects:
                         GLOBAL_MAP_LOCATION1_MASK_COLOR,
                         GLOBAL_MAP_LOCATION2_MASK_COLOR,
                         GLOBAL_MAP_LOCATION3_MASK_COLOR,
                         GLOBAL_MAP_LOCATION4_MASK_COLOR,
                         nil];
  }
  
  return mapLocationColors;
}

@end
