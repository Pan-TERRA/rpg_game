//
//  RPGAddFriendViewController.m
//  RPG Game
//
//  Created by Владислав Крут on 12/7/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAddFriendViewController.h"
  // Constants
#import "RPGNibNames.h"

@interface RPGAddFriendViewController ()

@property (nonatomic, assign, readwrite) IBOutlet UITextField *friendNickNameTextField;

@end

@interface RPGAddFriendViewController ()

@end

@implementation RPGAddFriendViewController

#pragma mark - Init

- (instancetype)init
{
  self = [super initWithNibName:kRPGAddFriendViewControllerNIBName bundle:nil];
  
  if (self != nil)
  {
    
  }
  
  return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  [self.friendNickNameTextField becomeFirstResponder];
}

#pragma mark - IBActions

- (IBAction)confirmAddFriend:(UIButton *)sender
{
  
}

- (IBAction)back:(UIButton *)sender
{
  [self.view removeFromSuperview];
  [self removeFromParentViewController];
}


@end
