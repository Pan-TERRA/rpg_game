//
//  RPGLocationMapViewController.m
//  RPG Game
//
//  Created by Степан Супинский on 12/3/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGLocationMapViewController.h"
  // Constants
#import "RPGNibNames.h"

@interface RPGLocationMapViewController ()

@property (readwrite, assign, nonatomic) IBOutlet UILabel *label;
@property (readonly, assign, nonatomic) NSInteger locationID;

@end

@implementation RPGLocationMapViewController

- (instancetype)initWithLocationID:(NSInteger)locationID
{
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

- (instancetype)init
{
  return [self initWithLocationID:-1];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.label.text = [NSString stringWithFormat:@"%ld", self.locationID];
}

- (IBAction)backAction:(UIButton *)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
