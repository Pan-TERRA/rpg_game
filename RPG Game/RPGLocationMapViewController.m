//
//  RPGLocationMapViewController.m
//  RPG Game
//
//  Created by Степан Супинский on 12/3/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGLocationMapViewController.h"
  // Views
#import "RPGBattleplaceView.h"
  // Constants
#import "RPGNibNames.h"

@interface RPGLocationMapViewController ()

@property (readonly, assign, nonatomic) NSInteger locationID;
@property (readwrite, retain, nonatomic) NSMutableArray<RPGBattleplaceView *> *battleplaceViews;

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
    self = [super initWithNibName:NIBName bundle:nil];
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
  self.battleplaceViews = [[NSMutableArray alloc] initWithObjects:
                                                   self.battleplaceView1,
                                                   self.battleplaceView2,
                           nil];
}

#pragma mark Actions

- (IBAction)backAction:(UIButton *)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Battleplace actions

- (IBAction)battleplaceClickAction:(UIButton *)sender
{
  // Clear selection
  for (RPGBattleplaceView *battleplaceView in self.battleplaceViews)
  {
    battleplaceView.selectedMarkImageView.hidden = YES;
  }
  
  RPGBattleplaceView *clickedBattleplaceView = (RPGBattleplaceView *)sender.superview;
  // Set selection
  clickedBattleplaceView.selectedMarkImageView.hidden = NO;
}


@end
