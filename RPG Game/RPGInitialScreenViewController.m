//
//  RPGInitialScreenViewController.m
//  RPG Game
//
//  Created by Степан Супинский on 11/1/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGInitialScreenViewController.h"
#import "RPGNetworkManager.h"
#import "RPGMainViewController.h"
#import "RPGLoginViewController.h"
// Constants
#import "RPGNibNames.h"

@interface RPGInitialScreenViewController ()

@end

@implementation RPGInitialScreenViewController

- (instancetype)init
{
  self = [super init];
  
  if (self != nil)
  {
    [self initWithNibName:kRPGInitialScreenViewControllerNIBName bundle:nil];
  }
  
  return self;
}

- (void)viewDidLoad
{
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

@end
