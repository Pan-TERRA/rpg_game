//
//  AppDelegate.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "AppDelegate.h"
#import "RPGNibNames.h"
#import "RPGRegistrationViewController.h"
#import "RPGBackgroundMusicController.h"
#import "NSUserDefaults+RPGVolumeSettings.h"
#import "RPGSFXEngine.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - Dealloc

- (void)dealloc
{
  [_loginViewController release];
  [_window release];
  [super dealloc];
}

#pragma mark -

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
  
//  RPGRegistrationViewController *registrationViewController = [[[RPGRegistrationViewController alloc]
//                                                                  init]
//                                                                  autorelease];
//  [self.window setRootViewController:registrationViewController];
 
  RPGLoginViewController *loginViewController = [[RPGLoginViewController alloc]
                                                 initWithNibName:@"RPGLoginViewController"
                                                          bundle:nil];
  self.loginViewController = loginViewController;
  [self.window setRootViewController:loginViewController];
  
  [loginViewController release];
  
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
    
    [RPGBackgroundMusicController sharedBackgroundMusicController];
    
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  [self saveVolumeSettingsToUserDefaults];
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  [self saveVolumeSettingsToUserDefaults];
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)saveVolumeSettingsToUserDefaults
{
  double musicVolume = [[RPGBackgroundMusicController sharedBackgroundMusicController] getVolume];
  double soundsVolume = [[RPGSFXEngine sharedSFXEngine] getVolume];
  BOOL isMusicPlaying = [[RPGBackgroundMusicController sharedBackgroundMusicController] isPlaying];
  BOOL isSoundsPlaying = [[RPGSFXEngine sharedSFXEngine] isPlaying];
  [[NSUserDefaults standardUserDefaults] setMusicVolume:musicVolume];
  [[NSUserDefaults standardUserDefaults] setSoundsVolume:soundsVolume];
  [[NSUserDefaults standardUserDefaults] setIsMusicPlaying:isMusicPlaying];
  [[NSUserDefaults standardUserDefaults] setIsSoundsPlaying:isSoundsPlaying];
}
@end
