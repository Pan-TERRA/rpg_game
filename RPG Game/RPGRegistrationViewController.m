//
//  RPGRegistrationViewController.m
//  RPG Game
//
//  Created by Степан Супинский on 10/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGRegistrationViewController.h"
#import "RPGLoginViewController.h"
#import "RPGNetworkManager+Registration.h"
#import "RPGRegistrationRequest+Serialization.h"
#import "RPGNibNames.h"

@interface RPGRegistrationViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property (nonatomic, retain, readonly) NSArray *classPickerData;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *submitButton;
@property (nonatomic, assign, readwrite) IBOutlet UIPickerView *classPicker;
@property (nonatomic, assign, readwrite) IBOutlet UITextField *emailTextField;
@property (nonatomic, assign, readwrite) IBOutlet UITextField *usernameTextField;
@property (nonatomic, assign, readwrite) IBOutlet UITextField *passwordTextField;
@property (nonatomic, assign, readwrite) IBOutlet UITextField *confirmPasswordTextField;
@property (nonatomic, assign, readwrite) IBOutlet UITextField *characterNameTextField;
@property (nonatomic, assign, readwrite) IBOutlet UIActivityIndicatorView *submitActivityIndicator;
@property (nonatomic, assign, readwrite) IBOutlet UIScrollView *scrollView;
@property (nonatomic, assign, readwrite) UITextField *activeField;

@end

@implementation RPGRegistrationViewController

#pragma mark - Init

- (instancetype)init
{
  self = [super initWithNibName:kRPGRegistrationViewControllerNIBName bundle:nil];
  
  if (self != nil)
  {
    //test data
    _classPickerData = [@[
                          @{ @"className": @"Researcher",
                             @"id": @1
                          }
                        ] retain];
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
  [_classPickerData release];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  
  [super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  UIInterfaceOrientationMask mask = UIInterfaceOrientationMaskAll;
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
  {
    mask = UIInterfaceOrientationMaskLandscape;
  }
  return mask;
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)aPickerView
{
  return 1;
}

- (NSInteger)pickerView:(UIPickerView *)aPickerView
numberOfRowsInComponent:(NSInteger)aComponent
{
  return self.classPickerData.count;
}

- (NSString *)pickerView:(UIPickerView *)aPickerView
             titleForRow:(NSInteger)aRow
            forComponent:(NSInteger)aComponent
{
  //TODO: remove hardcode
  return self.classPickerData[aRow][@"className"];
}

#pragma mark Error Representation

- (void)showErrorText:(NSString *)aText
{
//  self.errorLabel.text = aText;
//  [self.errorLabel setHidden:NO];
//  [self.errorLabel sizeToFit];
  
}

#pragma mark View State

- (void)setViewToWaitingForServerResponseState
{
  [self.submitButton setEnabled:NO];
  [self.submitActivityIndicator startAnimating];
}

- (void)setViewToNormalState
{
  [self.submitButton setEnabled:YES];
  [self.submitActivityIndicator stopAnimating];
}

#pragma mark IBActions

- (IBAction)submitButtonAction:(UIButton *)aSender
{
  NSString *emailFieldText = self.emailTextField.text;
  NSString *usernameFieldText = self.usernameTextField.text;
  NSString *passwordFieldText = self.passwordTextField.text;
  NSString *confirmPasswordFieldText = self.confirmPasswordTextField.text;
  NSString *characterNameFieldText = self.characterNameTextField.text;
  NSInteger selectedClassID = [self getSelectedClassID];
  
  if (!([emailFieldText isEqualToString:@""] &&
        [usernameFieldText isEqualToString:@""] &&
        [passwordFieldText isEqualToString:@""] &&
        [confirmPasswordFieldText isEqualToString:@""] &&
        [characterNameFieldText isEqualToString:@""]))
  {
    if ([passwordFieldText isEqualToString:confirmPasswordFieldText])
    {
      [self setViewToWaitingForServerResponseState];
      
      RPGRegistrationRequest *registrationRequest = [RPGRegistrationRequest registrationRequestWithEmail:emailFieldText
                                                                                                password:passwordFieldText
                                                                                                username:usernameFieldText
                                                                                           characterName:characterNameFieldText
                                                                                           characterType:selectedClassID];
      
      [[RPGNetworkManager sharedNetworkManager] registerWithRequest:registrationRequest
                                                  completionHandler:^(NSInteger statusCode)
       {
         [self setViewToNormalState];
         
         BOOL success = (statusCode == 0);
         if (success)
         {
           [self dismissViewControllerAnimated:YES completion:nil];
         }
         else
         {
           [self showErrorText:@"SOMETHING WENT WRONG"];
         }
       }];
    }
    else
    {
      [self showErrorText:@"Password doesn't match. Lorem ipsum if the message is too large."];
    }
  }
  else
  {
    [self showErrorText:@"Please fill in all required fields."];
  }
}

- (IBAction)cancelButtonAction:(UIButton *)aSender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)userDoneEnteringText:(UITextField *)aSender
{
  NSInteger nextTag = aSender.tag + 1;
  UIResponder *nextResponder = [aSender.superview viewWithTag:nextTag];
  [nextResponder becomeFirstResponder];
}

- (IBAction)userTappedView:(UITapGestureRecognizer *)aSender
{
  [self.activeField endEditing:YES];

}

- (NSInteger)getSelectedClassID
{
  NSInteger selectedClassIndex = [self.classPicker selectedRowInComponent:0];
  //TODO: remove hardcode
  return [self.classPickerData[selectedClassIndex][@"id"] integerValue];
}

#pragma mark - Notifications

- (void)keyboardWillShow:(NSNotification *)aNotification
{
  CGRect keyboardFrame = [aNotification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
  CGFloat adjustmentHeight = keyboardFrame.size.height;
  UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, adjustmentHeight + 10, 0.0);
  self.scrollView.contentInset = contentInsets;
  self.scrollView.scrollIndicatorInsets = contentInsets;
  
  CGRect viewRect = self.view.frame;
  viewRect.size.height -= keyboardFrame.size.height;
  if (!CGRectContainsPoint(viewRect, self.activeField.frame.origin))
  {
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

- (void)textFieldDidBeginEditing:(UITextField *)aTextField
{
  self.activeField = aTextField;
}

- (void)textFieldDidEndEditing:(UITextField *)aTextField
{
  self.activeField = nil;
}

@end
