  //
  //  RPGLocationMapViewController.m
  //  RPG Game
  //
  //  Created by Степан Супинский on 12/3/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGLocationMapViewController.h"
  // API
#import "RPGAdventuresFactory.h"
#import "RPGBattleViewController.h"
  // Controllers
#import "RPGAdventureGlobalMapViewController.h"
  // Views
#import "RPGBattleplaceView.h"
  // Constants
#import "RPGNibNames.h"

  //
BOOL locationExists(NSInteger locationID)
{
  return locationID >= 1 && locationID <= 1;
}


@interface RPGLocationMapViewController ()

@property (readonly, assign, nonatomic) NSInteger locationID;
@property (readwrite, assign, nonatomic) NSInteger chosenBattleplaceID;
@property (readwrite, retain, nonatomic) NSMutableArray<RPGBattleplaceView *> *battleplaceViews;

  // Outlets

@property (readwrite, assign, nonatomic) IBOutlet UIButton *toBattleButton;

  // Battleplace views
@property (readwrite, assign, nonatomic) IBOutlet RPGBattleplaceView *battleplaceView1;
@property (readwrite, assign, nonatomic) IBOutlet RPGBattleplaceView *battleplaceView2;
@property (readwrite, assign, nonatomic) IBOutlet RPGBattleplaceView *battleplaceView3;

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
  [super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
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


@end
