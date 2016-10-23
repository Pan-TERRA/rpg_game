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

@interface RPGLoginViewController () <UITextFieldDelegate>

@property (nonatomic, assign, readwrite) IBOutlet UILabel *errorMessageLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *loginButton;
@property (nonatomic, assign, readwrite) IBOutlet UITextField *emailInputField;
@property (nonatomic, assign, readwrite) IBOutlet UITextField *passwordInputField;
@property (nonatomic, assign, readwrite) IBOutlet UIActivityIndicatorView *loginActivityIndicator;
@property (nonatomic, assign, readwrite) IBOutlet UIScrollView *scrollView;
@property (nonatomic, assign, readwrite) UITextField *activeField;

@end

@implementation RPGLoginViewController

#pragma mark - Init

- (instancetype)init
{
  self = [super initWithNibName:kRPGLoginViewController bundle:nil];
  
  if (self != nil)
  {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(keyboardWillShow:)
                          name:UIKeyboardWillShowNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(keyboardWillHide:)
                          name:UIKeyboardWillHideNotification
                        object:nil];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  
  [super dealloc];
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

#pragma mark - Notifications

- (void)keyboardWillShow:(NSNotification *)aNotification
{
  CGRect keyboardFrame = [aNotification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
  CGFloat adjustmentHeight = keyboardFrame.size.height;
  UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, adjustmentHeight, 0.0);
  self.scrollView.contentInset = contentInsets;
  self.scrollView.scrollIndicatorInsets = contentInsets;
  
  CGRect viewRect = self.view.frame;
  viewRect.size.height -= keyboardFrame.size.height;
  if (!CGRectContainsPoint(viewRect, self.activeField.frame.origin)) {
    [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
  }
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
  UIEdgeInsets contentInsets = UIEdgeInsetsZero;
  self.scrollView.contentInset = contentInsets;
  self.scrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
  self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
  self.activeField = nil;
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
