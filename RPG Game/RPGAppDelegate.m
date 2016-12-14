//
//  AppDelegate.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAppDelegate.h"
  // Views
#import "RPGInitialScreenViewController.h"
 // Constants
#import "RPGNibNames.h"

@implementation RPGAppDelegate

#pragma mark - Dealloc

- (void)dealloc
{
  [_window release];
  
  [super dealloc];
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
  
  RPGInitialScreenViewController *initialScreenViewController = [[RPGInitialScreenViewController alloc] init];
  [self.window setRootViewController:initialScreenViewController];
  [initialScreenViewController release];
  
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
  
  return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
  return UIInterfaceOrientationMaskAll;
}

@end
