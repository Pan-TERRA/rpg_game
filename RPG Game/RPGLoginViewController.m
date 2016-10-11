//
//  RPGLoginViewController.m
//  RPG Game
//
//  Created by Степан Супинский on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGLoginViewController.h"

@interface RPGLoginViewController ()

@property (assign, nonatomic) IBOutlet UILabel *errorMessageLabel;

@property (assign, nonatomic) IBOutlet UITextField *usernameInputField;
@property (assign, nonatomic) IBOutlet UITextField *passwordInputField;

@end

@implementation RPGLoginViewController

#pragma mark - Init/dealloc

- (void)dealloc
{
  [super dealloc];
}

#pragma mark -

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.errorMessageLabel setHidden:YES];
}

#pragma mark - Actions

- (IBAction)forgotPasswordAction:(UIButton *)sender
{
  
}

- (IBAction)loginAction:(UIButton *)sender
{
  [self.errorMessageLabel setHidden:NO];
}

@end
