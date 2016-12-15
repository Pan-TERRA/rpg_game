  //
  //  RPGLocationMapViewController.m
  //  RPG Game
  //
  //  Created by Степан Супинский on 12/3/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGLocationMapViewController.h"
  // API
#import "RPGNetworkManager+RPGAdventures.h"
  // Controllers
#import "RPGAdventureGlobalMapViewController.h"
#import "RPGWaitingViewController.h"
#import "RPGBattleViewController.h"
  // Entities
#import "RPGLocationInfoResponse.h"
  // Views
#import "RPGBattleplaceView.h"
  // Misc
#import "UIViewController+RPGChildViewController.h"
#import "RPGAdventuresFactory.h"
  // Constants
#import "RPGNibNames.h"

static NSString * const kRPGLocationMapViewControllerLocationInfoBattlePlaceIDKey = @"battle_place_id";
static NSString * const kRPGLocationMapViewControllerLocationInfoStateKey = @"state";

typedef NS_ENUM(NSInteger, RPGLocationInfoState)
{
  kRPGLocationInfoIsClearedState,
  kRPGLocationInfoIsAvailableState,
  kRPGLocationInfoIsNotAvailableState
};

  // Helper functions
BOOL locationExists(NSInteger locationID)
{
  return locationID >= 1 && locationID <= 1;
}

#pragma mark

@interface RPGLocationMapViewController () <RPGBattleViewControllerDelegate>

@property (readonly, assign, nonatomic) NSInteger locationID;
@property (readwrite, assign, nonatomic) NSInteger chosenBattleplaceID;
@property (readwrite, retain, nonatomic) NSMutableArray<RPGBattleplaceView *> *battleplaceViews;
@property (readwrite, retain, nonatomic) RPGWaitingViewController *waitingViewController;
@property (readwrite, retain, nonatomic) NSArray<NSDictionary *> *locationInfo;

#pragma mark Outlets

@property (readwrite, assign, nonatomic) IBOutlet UIButton *toBattleButton;

#pragma mark Battleplace views

@property (readwrite, assign, nonatomic) IBOutlet RPGBattleplaceView *battleplaceView1;
@property (readwrite, assign, nonatomic) IBOutlet RPGBattleplaceView *battleplaceView2;
@property (readwrite, assign, nonatomic) IBOutlet RPGBattleplaceView *battleplaceView3;

#pragma mark

@end

@implementation RPGLocationMapViewController

#pragma mark - Init

- (instancetype)initWithLocationID:(NSInteger)locationID
{
  if (locationExists(locationID))
  {
    NSString *NIBName = [NSString stringWithFormat:@"%@%ld", kRPGLocationMapSuffixlessNIBName, locationID];
    self = [self initWithNibName:NIBName bundle:nil];
    
    if (self != nil)
    {
      _locationID = locationID;
    }
  }
  else
  {
    [self release];
    self = nil;
  }
  
  return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nil];
  
  if (self != nil)
  {
    _battleplaceViews = [NSMutableArray new];
    _chosenBattleplaceID = -1;
    _locationID = -1;
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithLocationID:-1];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_battleplaceViews release];
  [_waitingViewController release];
  [_locationInfo release];
  [super dealloc];
}

#pragma mark - Getters/Setters

- (void)setLocationInfo:(NSArray<NSDictionary *> *)locationInfo
{
  if (_locationInfo != locationInfo)
  {
    [_locationInfo release];
    _locationInfo = [locationInfo retain];
    
    [self updateBattleplaces];
  }
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self update];
  
  self.battleplaceViews = [NSMutableArray arrayWithObjects:
                           self.battleplaceView1,
                           self.battleplaceView2,
                           self.battleplaceView3,
                           nil];
}

#pragma mark - IBActions

- (IBAction)backAction:(UIButton *)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)toBattleAction:(UIButton *)sender
{
  RPGAdventuresFactory *adventuresFactory = [[[RPGAdventuresFactory alloc] initWithBattleplaceID:self.chosenBattleplaceID] autorelease];
  RPGBattleViewController *battleViewController = [[RPGBattleViewController alloc] initWithBattleFactory:adventuresFactory];
  battleViewController.battleViewControllerDelegate = self;
  
  [self presentViewController:[battleViewController autorelease]
                     animated:YES
                   completion:nil];
}

#pragma mark Battleplace actions

- (IBAction)battleplaceClickAction:(UIButton *)sender
{
    // Clear selection
  for (RPGBattleplaceView *battleplaceView in self.battleplaceViews)
  {
    battleplaceView.selectedMarkImageView.hidden = YES;
  }
  
    // Set selection
  RPGBattleplaceView *clickedBattleplaceView = (RPGBattleplaceView *)sender.superview;
  clickedBattleplaceView.selectedMarkImageView.hidden = NO;
  
    // Get battleplace ID and set it to a property
  NSInteger clickedBattleplaceID = clickedBattleplaceView.tag;
  self.chosenBattleplaceID = clickedBattleplaceID;
  
  self.toBattleButton.enabled = YES;
}

#pragma mark - RPGBattleViewControllerDelegate

- (void)battleViewControllerDidEndBattle
{
  [self update];
}

#pragma mark - Helper methods

- (void)update
{
  RPGWaitingViewController *waitingViewController = [[RPGWaitingViewController alloc] initWithMessage:@"Please wait"
                                                                                           completion:nil];
  [self showWaitingModal:[waitingViewController autorelease]];
  
  [[RPGNetworkManager sharedNetworkManager] getLocationInfoWithLocationID:self.locationID
                                                        completionHandler:^(RPGStatusCode aNetworkStatusCode, RPGLocationInfoResponse *aResponse)
  {
    if (aNetworkStatusCode == kRPGStatusCodeOK
        && aResponse.status == kRPGStatusCodeOK)
    {
      self.locationInfo = aResponse.locationInfo;
      [self removeWaitingModal];
    }
  }];
}

- (void)updateBattleplaces
{
  for (RPGBattleplaceView *battleplaceView in self.battleplaceViews)
  {
    for (NSDictionary *battlePlaceInfo in self.locationInfo)
    {
      if ([battlePlaceInfo[kRPGLocationMapViewControllerLocationInfoBattlePlaceIDKey] integerValue] == battleplaceView.tag)
      {
        RPGLocationInfoState state = [battlePlaceInfo[kRPGLocationMapViewControllerLocationInfoStateKey] integerValue];
        [self setBattlePlaceView:battleplaceView toState:state];
      }
    }
  }
}

- (void)setBattlePlaceView:(RPGBattleplaceView *)aBattleplaceView toState:(RPGLocationInfoState)aState
{
  switch (aState)
  {
    case kRPGLocationInfoIsAvailableState:
    {
      aBattleplaceView.hidden = NO;
      break;
    }
      
    default:
    {
      aBattleplaceView.hidden = YES;
      break;
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
