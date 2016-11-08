//
//  RPGInitialScreenViewController.m
//  RPG Game
//
//  Created by Степан Супинский on 11/1/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGInitialScreenViewController.h"
  // Views
#import "RPGMainViewController.h"
#import "RPGLoginViewController.h"
  // API
#import "RPGNetworkManager.h"
  // Constants
#import "RPGNibNames.h"

@interface RPGInitialScreenViewController ()

@end

@implementation RPGInitialScreenViewController

#pragma mark - Init

- (instancetype)init
{
  self = [super init];
  
  if (self != nil)
  {
    [self initWithNibName:kRPGInitialScreenViewControllerNIBName bundle:nil];
  }
  
  return self;
}

#pragma mark - UIViewController

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  
  [[RPGNetworkManager sharedNetworkManager] requestIfCurrentTokenIsValidWithCompletionHandler:^(BOOL isValid)
   {
     UIViewController *viewControllerToBePresented = nil;
     
     if (isValid)
     {
       viewControllerToBePresented = [[RPGMainViewController alloc] init];
     }
     else
     {
       viewControllerToBePresented = [[RPGLoginViewController alloc] init];
     }
    
     [self presentViewController:[viewControllerToBePresented autorelease]
                        animated:YES
                      completion:nil];
   }];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  return UIInterfaceOrientationMaskLandscape;
}

@end
