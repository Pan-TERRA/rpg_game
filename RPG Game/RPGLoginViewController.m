//
//  RPGLoginViewController.m
//  RPG Game
//
//  Created by Степан Супинский on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGLoginViewController.h"
#import "RPGRegistrationViewController.h"
#import "RPGMainViewController.h"
#import "RPGNetworkManager+Authorization.h"
#import "RPGAuthorizationLoginRequest+Serialization.h"
#import "RPGNibNames.h"

@interface RPGLoginViewController ()

@property (nonatomic, assign, readwrite) IBOutlet UILabel *errorMessageLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *loginButton;
@property (nonatomic, assign, readwrite) IBOutlet UITextField *emailInputField;
@property (nonatomic, assign, readwrite) IBOutlet UITextField *passwordInputField;
@property (nonatomic, assign, readwrite) IBOutlet UIActivityIndicatorView *loginActivityIndicator;

@end

@implementation RPGLoginViewController

#pragma mark - Init

- (instancetype)init
{
  return [super initWithNibName:kRPGLoginViewController
                         bundle:nil];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
}

#pragma mark - Changing UI state

- (void)setViewToWaitingForServerResponseState
{
  [self.loginButton setEnabled:NO];
  [self.loginActivityIndicator startAnimating];
}

- (void)setViewToNormalState
{
  [self.loginButton setEnabled:YES];
  [self.loginActivityIndicator stopAnimating];
}

#pragma mark - Error representation

- (void)showErrorText:(NSString *)aText
{
  self.errorMessageLabel.text = aText;
  [self.errorMessageLabel setHidden:NO];
  [self.errorMessageLabel sizeToFit];
}

#pragma mark - Actions

- (IBAction)forgotPasswordAction:(UIButton *)aSender
{
  
}

- (IBAction)signupAction:(UIButton *)aSender
{
  RPGRegistrationViewController *registrationViewController = [[RPGRegistrationViewController alloc] init];
  [self presentViewController:registrationViewController
                     animated:YES
                   completion:nil];
  [registrationViewController release];
}

- (IBAction)loginAction:(UIButton *)aSender
{
  NSString *email = self.emailInputField.text;
  NSString *password = self.passwordInputField.text;
  
  if (email && password &&
      ![email isEqualToString:@""] &&
      ![password isEqualToString:@""])
  {
    [self setViewToWaitingForServerResponseState];
    
    RPGAuthorizationLoginRequest *request = [RPGAuthorizationLoginRequest
                                             authorizationRequestWithEmail:email
                                             password:password];
    
    [[RPGNetworkManager sharedNetworkManager] loginWithRequest:request
                                             completionHandler:^(NSInteger statusCode)
     {
       [self setViewToNormalState];
       
       BOOL success = (statusCode == 0);
       if (success)
       {
         RPGMainViewController *mainViewController = [[RPGMainViewController alloc] init];
         [self presentViewController:mainViewController
                            animated:YES
                          completion:nil];
         [mainViewController release];
       }
       else
       {
         // TODO: add switch that depends on error code
         [self showErrorText:@"Password or email are incorrect"];
       }
     }];
  }
  else
  {
    [self showErrorText:@"Please fill in all required fields."];
  }
}

@end