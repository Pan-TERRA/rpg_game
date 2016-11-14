//
//  RPGRegistrationViewController.m
//  RPG Game
//
//  Created by Степан Супинский on 10/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGRegistrationViewController.h"
  // Views
#import "RPGLoginViewController.h"
  // API
#import "RPGNetworkManager+Registration.h"
#import "RPGNetworkManager+Classes.h"
  // Entities
#import "RPGRegistrationRequest.h"
  // Constants
#import "RPGNibNames.h"

static CGFloat kRPGViewControllercContentInsetsGap = 10.0;

@interface RPGRegistrationViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property (nonatomic, assign, readwrite) IBOutlet UIScrollView *scrollView;
@property (nonatomic, assign, readwrite) UITextField *activeField;

@property (nonatomic, assign, readwrite) IBOutlet UITextField *emailTextField;
@property (nonatomic, assign, readwrite) IBOutlet UITextField *usernameTextField;
@property (nonatomic, assign, readwrite) IBOutlet UITextField *passwordTextField;
@property (nonatomic, assign, readwrite) IBOutlet UITextField *confirmPasswordTextField;
@property (nonatomic, assign, readwrite) IBOutlet UITextField *characterNameTextField;
@property (nonatomic, assign, readwrite) IBOutlet UIPickerView *classPicker;
@property (nonatomic, retain, readwrite) NSArray *classPickerData;

@property (nonatomic, assign, readwrite) IBOutlet UIActivityIndicatorView *submitActivityIndicator;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *submitButton;

@end

@implementation RPGRegistrationViewController

#pragma mark - Init

- (instancetype)init
{
  self = [super initWithNibName:kRPGRegistrationViewControllerNIBName bundle:nil];
  
  if (self != nil)
  {
    //test data
    _classPickerData = [[NSArray alloc] init];
    
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
  
  [[RPGNetworkManager sharedNetworkManager] getClassInfoByID:1 completionHandler:
   ^(NSInteger statusCode, NSDictionary *skillInfo)
  {
    switch (statusCode)
    {
      case kRPGStatusCodeOK:
      {
        self.classPickerData = [NSArray arrayWithObject:skillInfo];
        [self.classPicker reloadAllComponents];
        break;
      }
      case kRPGStatusCodeWrongEmail:
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
      default:
      {
        break;
      }
    }

  }];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  return UIInterfaceOrientationMaskLandscape;
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
  return self.classPickerData[aRow][@"name"];
}

#pragma mark Error Representation

  // TODO: Redo
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

- (IBAction)cancelButtonAction:(UIButton *)aSender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)submitButtonAction:(UIButton *)aSender
{
  NSString *emailFieldText = self.emailTextField.text;
  NSString *usernameFieldText = self.usernameTextField.text;
  NSString *passwordFieldText = self.passwordTextField.text;
  NSString *confirmPasswordFieldText = self.confirmPasswordTextField.text;
  NSString *characterNameFieldText = self.characterNameTextField.text;
  NSInteger selectedClassID = [self getSelectedClassID];
  
  if ([self textFieldsNotEmpty])
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

- (BOOL)textFieldsNotEmpty
{
  return self.emailTextField.text.length != 0 &&
         self.usernameTextField.text.length != 0 &&
         self.passwordTextField.text.length != 0 &&
         self.confirmPasswordTextField.text.length != 0 &&
         self.characterNameTextField.text.length != 0;
}

- (NSInteger)getSelectedClassID
{
  NSInteger selectedClassIndex = [self.classPicker selectedRowInComponent:0];
  
  return [self.classPickerData[selectedClassIndex][@"id"] integerValue];
}

  // "return key" ending editing
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

#pragma mark - Notifications

- (void)keyboardWillShow:(NSNotification *)aNotification
{
  CGRect keyboardFrame = [aNotification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
  CGFloat adjustmentHeight = keyboardFrame.size.height + kRPGViewControllercContentInsetsGap;
  UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, adjustmentHeight, 0.0);
  self.scrollView.contentInset = contentInsets;
  self.scrollView.scrollIndicatorInsets = contentInsets;
  
    // Shrink view
  CGRect viewRect = self.view.frame;
  viewRect.size.height -= keyboardFrame.size.height;
    // Check if input text field is not visible
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

  // First responder toggle
- (void)textFieldDidBeginEditing:(UITextField *)aTextField
{
  self.activeField = aTextField;
}

- (void)textFieldDidEndEditing:(UITextField *)aTextField
{
  self.activeField = nil;
}

@end
