//
//  RPGLocationMapViewController.m
//  RPG Game
//
//  Created by Степан Супинский on 12/3/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGLocationMapViewController.h"

@interface RPGLocationMapViewController ()

@property (readwrite, assign, nonatomic) IBOutlet UILabel *label;
@property (readonly, assign, nonatomic) NSInteger locationID;

@end

@implementation RPGLocationMapViewController

- (instancetype)initWithLocationID:(NSInteger)locationID
{
  self = [super init];
  if (self != nil)
  {
    if (locationID >= 0)
    {
      _locationID = locationID;
    }
    else
    {
      [self release];
      self = nil;
    }
  }
  return self;
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
