//
//  RPGInitialScreenViewController.m
//  RPG Game
//
//  Created by Степан Супинский on 11/1/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGInitialScreenViewController.h"
  // API
#import "RPGNetworkManager.h"
  // Views
#import "RPGMainViewController.h"
#import "RPGLoginViewController.h"
  //Misc
#import "RPGBackgroundMusicController.h"
  // Constants
#import "RPGNibNames.h"

@implementation RPGInitialScreenViewController

#pragma mark - Init

- (instancetype)init
{  
  return [super initWithNibName:kRPGInitialScreenViewControllerNIBName
                         bundle:nil];
}

#pragma mark - UIViewController

- (void)viewDidAppear:(BOOL)anAnimated
{
  [super viewDidAppear:anAnimated];
  
  [[RPGNetworkManager sharedNetworkManager] requestIfCurrentTokenIsValidWithCompletionHandler:^(BOOL anIsValidFlag)
  {
    UIViewController *viewControllerToBePresented = nil;
     
    if (anIsValidFlag)
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

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [RPGBackgroundMusicController sharedBackgroundMusicController];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  return UIInterfaceOrientationMaskLandscape;
}

@end
