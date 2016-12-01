//
//  RPGAdventureGlobalMapViewController.m
//  RPG Game
//
//  Created by Степан Супинский on 12/1/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAdventureGlobalMapViewController.h"
#import "RPGNibNames.h"
#import "UIView+RPGColorOfPoint.h"

@interface RPGAdventureGlobalMapViewController ()

@property (readwrite, assign, nonatomic) IBOutlet UIImageView *maskImageView;
@property (readwrite, assign, nonatomic) IBOutlet UIImageView *displayImageView;

@property (readwrite, assign, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidthConstraint;
@property (readwrite, assign, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightConstraint;

@end

@implementation RPGAdventureGlobalMapViewController

- (instancetype)init
{
  return [self initWithNibName:kRPGAdventureGlobalMapViewControllerNIBName bundle:nil];
}

- (void)viewDidLayoutSubviews
{
  self.contentViewWidthConstraint.constant = self.maskImageView.frame.size.width;
  self.contentViewHeightConstraint.constant = self.maskImageView.frame.size.height;
}

- (IBAction)mapTappedAction:(UITapGestureRecognizer *)gestureRecognizer
{
  CGPoint tapLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
  NSLog(@"%@", [self.maskImageView colorOfPoint:tapLocation]);
}

- (void)dealloc
{
  [super dealloc];
}
@end
