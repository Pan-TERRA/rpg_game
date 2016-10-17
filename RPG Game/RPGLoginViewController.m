//
//  RPGLoginViewController.m
//  RPG Game
//
//  Created by Степан Супинский on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGLoginViewController.h"
#import "RPGNetworkManager.h"
#import "RPGAuthorizationLoginRequest.h"
#import "RPGAuthorizationLoginResponse.h"

@interface RPGLoginViewController ()

@property (assign, nonatomic) IBOutlet UILabel *errorMessageLabel;

@property (assign, nonatomic) IBOutlet UITextField *emailInputField;
@property (assign, nonatomic) IBOutlet UITextField *passwordInputField;

@end

@implementation RPGLoginViewController

#pragma mark - Init/dealloc

- (instancetype)init
{
  return [super initWithNibName:@"RPGLoginViewController"
                         bundle:nil];
}

- (void)dealloc
{
  [super dealloc];
}

#pragma mark - View Controller

- (void)viewDidLoad
{
  [super viewDidLoad];
}

#pragma mark Error representation

- (void)showErrorText:(NSString *)text
{
  self.errorMessageLabel.text = text;
  [self.errorMessageLabel setHidden:NO];
  [self.errorMessageLabel sizeToFit];
}

#pragma mark Actions

- (IBAction)forgotPasswordAction:(UIButton *)sender
{
  
}

- (IBAction)loginAction:(UIButton *)sender
{
  NSString *email = self.emailInputField.text;
  NSString *password = self.passwordInputField.text;
  
  if (email && password
      && ![email isEqualToString:@""]
      && ![password isEqualToString:@""])
  {
    RPGAuthorizationLoginRequest *request = [RPGAuthorizationLoginRequest authorizationRequestWithEmail:email
                                                                                               password:password];
    [[RPGNetworkManager sharedNetworkManager] loginWithRequest:request
                                             completionHandler:^(RPGAuthorizationLoginResponse *response)
     {
       // TODO: Proper response status check
       BOOL success = response != nil && response.username != nil; //response.status
       NSLog(@"%d", success);
       if (!success)
       {
         [self performSelectorOnMainThread:@selector(showErrorText:)
                                withObject:@"Password or email are incorrect"
                             waitUntilDone:NO];
       }
     }];
  }
  else
  {
    [self showErrorText:@"Please fill in all required fields."];
  }
}

@end
