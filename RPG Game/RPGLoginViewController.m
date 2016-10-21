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
#import "RPGStatusCodes.h"

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
  return [super initWithNibName:kRPGLoginViewController bundle:nil];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
}

#pragma mark View State

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

#pragma mark IBActions

- (IBAction)editingDidChange:(UITextField *)sender
{
  if (self.emailInputField.text.length == 0 || self.passwordInputField.text.length == 0)
  {
    self.loginButton.enabled = NO;
  }
  else
  {
    self.loginButton.enabled = YES;
  }
}

//- (IBAction)forgotPasswordAction:(UIButton *)sender
//=======
//#pragma mark - Error Representation
//
//- (void)showErrorText:(NSString *)aText
//{
//  self.errorMessageLabel.text = aText;
//  [self.errorMessageLabel setHidden:NO];
//  [self.errorMessageLabel sizeToFit];
//}
//
//#pragma mark - IBActions
//
//- (IBAction)forgotPasswordAction:(UIButton *)aSender
//>>>>>>> development


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
  
  if (![email isEqualToString:@""] && ![password isEqualToString:@""])
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
           RPGMainViewController *mainViewController = [[RPGMainViewController alloc] initWithNibName:kRPGMainView
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
}

@end
