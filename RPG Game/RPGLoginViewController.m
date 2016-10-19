//
//  RPGLoginViewController.m
//  RPG Game
//
//  Created by Степан Супинский on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNibNames.h"
#import "RPGLoginViewController.h"
#import "RPGNetworkManager+Authorization.h"
#import "RPGRegistrationViewController.h"
#import "RPGMainViewController.h"
#import "RPGStatusCodes.h"

@interface RPGLoginViewController ()

@property (assign, nonatomic) IBOutlet UILabel *errorMessageLabel;
@property (assign, nonatomic) IBOutlet UIButton *loginButton;
@property (assign, nonatomic) IBOutlet UITextField *emailInputField;
@property (assign, nonatomic) IBOutlet UITextField *passwordInputField;
@property (assign, nonatomic) IBOutlet UIActivityIndicatorView *loginActivityIndicator;

@end

@implementation RPGLoginViewController

#pragma mark - Init/dealloc

- (instancetype)init
{
  return [super initWithNibName:@"RPGLoginViewController"
                         bundle:nil];
}

#pragma mark - View Controller

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

- (IBAction)signupAction:(UIButton *)sender
{
  RPGRegistrationViewController *registrationViewController = [[RPGRegistrationViewController alloc] init];
  [self presentViewController:registrationViewController
                     animated:YES
                   completion:nil];
  [registrationViewController release];
}

- (IBAction)loginAction:(UIButton *)sender
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
       // statusCode = kRPGStatusCodeOk;
       [self setViewToNormalState];
       
       switch (statusCode)
       {
         case kRPGStatusCodeOk:
         {
           RPGMainViewController *mainViewController = [[RPGMainViewController alloc] initWithNibName:kRPGMainMenu
                                                                                               bundle:nil];
           [self presentViewController:mainViewController
                              animated:YES
                            completion:nil];
           [mainViewController release];
           break;
         }
         case kRPGStatusCodeUserDoesNotExist:
         case kRPGStatusCodeWrongPassword:
         {
           UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                    message:@"Invalid credentials"
                                                                             preferredStyle:UIAlertControllerStyleAlert];
           UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                              style:UIAlertActionStyleDefault
                                                            handler:nil];
           [alertController addAction:okAction];
           [self presentViewController:alertController animated:YES completion:nil];
           break;
         }
         // TODO: case kRPGStatusCodeWrongJSON - we need to resend login request
         default:
         {
           break;
         }
       }
     }];
  }
  else
  {
    [self showErrorText:@"Please fill in all required fields."];
  }
}

@end
