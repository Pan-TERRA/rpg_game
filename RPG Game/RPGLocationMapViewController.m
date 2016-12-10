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

@interface RPGLocationMapViewController ()

@property (readonly, assign, nonatomic) NSInteger locationID;
@property (readwrite, assign, nonatomic) NSInteger chosenBattleplaceID;
@property (readwrite, retain, nonatomic) NSMutableArray<RPGBattleplaceView *> *battleplaceViews;

  // Outlets

@property (readwrite, assign, nonatomic) IBOutlet UIButton *toBattleButton;

  // Battleplace views
@property (readwrite, assign, nonatomic) IBOutlet RPGBattleplaceView *battleplaceView1;
@property (readwrite, assign, nonatomic) IBOutlet RPGBattleplaceView *battleplaceView2;

@end

@implementation RPGLocationMapViewController

#pragma mark - Init

- (instancetype)initWithLocationID:(NSInteger)locationID
{
    // Check if location with given ID exists
  if (locationID > 0 && locationID <= 1)
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
                           nil];
}

#pragma mark - IBActions

- (IBAction)backAction:(UIButton *)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)toBattleAction:(UIButton *)sender
{
    //TODO: battle init with location id and battleplace id (no API yet)
  NSLog(@"Battle!");
  
  RPGAdventuresFactory *adventuresFacory = [[[RPGAdventuresFactory alloc] init] autorelease];
  RPGBattleViewController *battleViewController = [[RPGBattleViewController alloc] initWithBattleFactory:adventuresFacory];
  
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
  
    // Get battleplace ID and set it to property
  NSInteger clickedBattleplaceID = clickedBattleplaceView.tag;
  self.chosenBattleplaceID = clickedBattleplaceID;
  
  self.toBattleButton.enabled = YES;
}


@end
