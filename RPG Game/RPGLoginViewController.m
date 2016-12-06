//
//  RPGLoginViewController.m
//  RPG Game
//
//  Created by Степан Супинский on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGLoginViewController.h"
  // API
#import "RPGNetworkManager+Authorization.h"
  // Controllers
#import "RPGAlertController+RPGErrorHandling.h"
  // Views
#import "RPGMainViewController.h"
#import "RPGRegistrationViewController.h"
  // Entities
#import "RPGAuthorizationLoginRequest.h"
  // Constants
#import "RPGNibNames.h"
#import "RPGStatusCodes.h"

@interface RPGLoginViewController () <UITextFieldDelegate>

@property (nonatomic, assign, readwrite) IBOutlet UIButton *loginButton;
@property (nonatomic, assign, readwrite) IBOutlet UITextField *emailInputField;
@property (nonatomic, assign, readwrite) IBOutlet UITextField *passwordInputField;
@property (nonatomic, assign, readwrite) IBOutlet UIActivityIndicatorView *loginActivityIndicator;
@property (nonatomic, copy, readwrite) void (^loginCompletionHandler)(RPGStatusCode);

@end

@implementation RPGLoginViewController

#pragma mark - Init

- (instancetype)init
{
  self = [super initWithNibName:kRPGLoginViewControllerNIBName bundle:nil];
  
  if (self != nil)
  {
    __block typeof(self) weakSelf = self;
    _loginCompletionHandler = [^(RPGStatusCode aNetworkStatusCode)
    {
      [self setViewToNormalState];
      
      switch (aNetworkStatusCode)
      {
        case kRPGStatusCodeOK:
        {
          RPGMainViewController *mainViewController = [[[RPGMainViewController alloc] init] autorelease];
          [weakSelf presentViewController:mainViewController animated:YES completion:nil];
          [weakSelf.emailInputField setText:@""];
          [weakSelf.passwordInputField setText:@""];
          break;
        }
          
        default:
        {
          if ([self canHandleStatusCode:aNetworkStatusCode])
          {
            [RPGAlertController showErrorWithStatusCode:aNetworkStatusCode
                                      completionHandler:nil];
          }
          else
          {
            [RPGAlertController handleDefaultError];
          }
          break;
        }
      }
    } copy];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  [_loginCompletionHandler release];
  
  [super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  return UIInterfaceOrientationMaskLandscape;
}

#pragma mark - View State

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

#pragma mark - IBActions

- (IBAction)editingDidChange:(UITextField *)aSender
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

- (IBAction)forgotPasswordAction:(UIButton *)sender
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
  
  if (email.length != 0 && password.length != 0)
  {
    [self setViewToWaitingForServerResponseState];
    
    RPGAuthorizationLoginRequest *request = [RPGAuthorizationLoginRequest
                                             authorizationRequestWithEmail:email
                                             password:password];
    
    [[RPGNetworkManager sharedNetworkManager] loginWithRequest:request
                                             completionHandler:self.loginCompletionHandler];
  }
}

#pragma mark - RPGViewController

- (IBAction)userDoneEnteringText:(UITextField *)aSender
{
  [[aSender.superview.superview viewWithTag:aSender.tag + 1] becomeFirstResponder];
}

- (IBAction)passwordTextFieldDidReturn:(UITextField *)aSender
{
  [self loginAction:nil];
  [aSender endEditing:YES];
}

#pragma mark - API

- (void)loginActionWithEmail:(NSString *)anEmail password:(NSString *)aPassword
{
  
  RPGAuthorizationLoginRequest *request = [RPGAuthorizationLoginRequest
                                           authorizationRequestWithEmail:anEmail
                                           password:aPassword];
  
  [[RPGNetworkManager sharedNetworkManager] loginWithRequest:request
                                           completionHandler:self.loginCompletionHandler];
}

#pragma mark - Helper Methods

- (BOOL)canHandleStatusCode:(RPGStatusCode)aStatusCode
{
  return aStatusCode == kRPGStatusCodeWrongEmail
  || aStatusCode == kRPGStatusCodeUserDoesNotExist
  || aStatusCode == kRPGStatusCodeWrongPassword;
}

@end
