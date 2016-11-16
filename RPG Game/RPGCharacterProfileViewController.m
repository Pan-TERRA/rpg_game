//
//  RPGCharacterProfileViewController.m
//  RPG Game
//
//  Created by Максим Шульга on 11/16/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGCharacterProfileViewController.h"
#import "RPGNibNames.h"

@interface RPGCharacterProfileViewController ()

@end

@implementation RPGCharacterProfileViewController

#pragma mark - Init

- (instancetype)init
{
  return [super initWithNibName:kRPGCharacterProfileViewControllerNIBName bundle:nil];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  return UIInterfaceOrientationMaskLandscape;
}

@end
