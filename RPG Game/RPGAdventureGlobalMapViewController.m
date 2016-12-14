//
//  RPGAdventureGlobalMapViewController.m
//  RPG Game
//
//  Created by Степан Супинский on 12/1/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAdventureGlobalMapViewController.h"
  // API
#import "RPGNetworkManager+RPGAdventures.h"
  // Controllers
#import "RPGLocationMapViewController.h"
#import "RPGWaitingViewController.h"
  // Entities
#import "RPGAvailableLocationsResponse.h"
  // Misc
#import "UIView+RPGColorOfPoint.h"
#import "UIColor+RPGColorEquality.h"
#import "UIViewController+RPGChildViewController.h"
  // Constants
#import "RPGNibNames.h"
#import "RPGStatusCodes.h"

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
@property (readwrite, retain, nonatomic) RPGWaitingViewController *waitingViewController;
@property (readwrite, retain, nonatomic) NSArray<NSNumber *> *availableLocationsIDs;

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
  [_waitingViewController release];
  [_availableLocationsIDs release];
  [super dealloc];
}

#pragma mark - Getters/Setters

- (void)setAvailableLocationsIDs:(NSArray<NSNumber *> *)availableLocationsIDs
{
  if (_availableLocationsIDs != availableLocationsIDs)
  {
    [_availableLocationsIDs release];
    _availableLocationsIDs = [availableLocationsIDs retain];
    
    [self updateAvailableLocations];
  }
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.lockViews = [NSMutableArray arrayWithObjects:self.lock1, self.lock2,
                    self.lock3, self.lock4, self.lock4, self.lock5, self.lock6,
                    self.lock7, self.lock8, self.lock9, nil];
  
  [self update];
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

#pragma mark - Helper methods

- (void)update
{
  RPGWaitingViewController *waitingViewController = [[RPGWaitingViewController alloc] initWithMessage:@"Please wait"
                                                                                           completion:nil];
  [self showWaitingModal:[waitingViewController autorelease]];
  
  [[RPGNetworkManager sharedNetworkManager] fetchAvailableLocationsWithCompletionHandler:^(RPGStatusCode networkStatusCode, RPGAvailableLocationsResponse *aResponse)
   {
     if (networkStatusCode == kRPGStatusCodeOK
         && aResponse.status == kRPGStatusCodeOK)
     {
       self.availableLocationsIDs = aResponse.locationsIDs;
       [self removeWaitingModal];
     }
   }];
}

#pragma mark Locks

- (void)updateAvailableLocations
{
  for (UIImageView *lockView in [self lockViews])
  {
    lockView.hidden = NO;
    
    for (NSNumber *locationIDNumber in self.availableLocationsIDs)
    {
      if ([locationIDNumber integerValue] == lockView.tag)
      {
        lockView.hidden = YES;
      }
    }
  }
}

#pragma mark Waiting modal

- (void)showWaitingModal:(RPGWaitingViewController *)waitingViewController
{
  self.waitingViewController = waitingViewController;
  [self addChildViewController:waitingViewController
                          view:self.view];
}

- (void)removeWaitingModal
{
  [self.waitingViewController.view removeFromSuperview];
  [self.waitingViewController removeFromParentViewController];
}

@end
