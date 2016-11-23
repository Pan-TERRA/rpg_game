//
//  RPGRegistrationViewController.m
//  RPG Game
//
//  Created by Степан Супинский on 10/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGRegistrationViewController.h"
  // API
#import "RPGNetworkManager+Registration.h"
#import "RPGNetworkManager+Classes.h"
  // Controllers
#import "RPGAlertController+RPGErrorHandling.h"
#import "RPGLoginViewController.h"
  // Views
#import "RPGLoginViewController.h"
  // Entities
#import "RPGRegistrationRequest.h"
  // Constants
#import "RPGNibNames.h"

@interface RPGRegistrationViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

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
    _classPickerData = [[NSArray alloc] init];
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
    // TODO: remove 
  NSInteger selectedClassID = 1;
  
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
         
         switch (statusCode)
         {
           case kRPGStatusCodeOK:
           {
             RPGLoginViewController *loginViewController = [[[RPGLoginViewController alloc] init] autorelease];
             [self presentViewController:loginViewController animated:YES completion:^
             {
               [loginViewController loginActionWithEmail:self.emailTextField.text
                                                password:self.passwordTextField.text];
             }];
             break;
           }
             
           case kRPGStatusCodeWrongEmail:
           {
             [RPGAlertController showErrorWithStatusCode:kRPGStatusCodeWrongEmail
                                       completionHandler:nil];
             break;
           }
             
           case kRPGStatusCodeWrongJSON:
           {
             [RPGAlertController showErrorWithStatusCode:kRPGStatusCodeWrongJSON
                                       completionHandler:nil];
             break;
           }
             
           case kRPGStatusCodeEmailAlreadyTaken:
           {
             [RPGAlertController showErrorWithStatusCode:kRPGStatusCodeEmailAlreadyTaken
                                       completionHandler:nil];
             break;
           }
             
           case kRPGStatusCodeUsernameAlreadyTaken:
           {
             [RPGAlertController showErrorWithStatusCode:kRPGStatusCodeUsernameAlreadyTaken
                                       completionHandler:nil];
             break;
           }
             
           default:
           {
             [RPGAlertController handleDefaultError];
             break;
           }
         }
       }];
    }
    else
    {
      NSString *message = @"Password doesn't match. Lorem ipsum if the message is too large.";
      [RPGAlertController showAlertWithTitle:nil
                                     message:message
                                 actionTitle:nil
                                  completion:^
      {
        dispatch_async(dispatch_get_main_queue(), ^
        {
          [self fillEmptyAllRegistrationFields];
        });
      }];
    }
  }
  else
  {
    NSString *message = @"Please fill in all required fields.";
    [RPGAlertController showAlertWithTitle:nil
                                   message:message
                               actionTitle:nil
                                completion:^
     {
       dispatch_async(dispatch_get_main_queue(), ^
        {
          [self fillEmptyAllRegistrationFields];
        });
     }];
  }
}

- (NSInteger)getSelectedClassID
{
  NSInteger selectedClassIndex = [self.classPicker selectedRowInComponent:0];
  
  return [self.classPickerData[selectedClassIndex][@"id"] integerValue];
}

#pragma mark - RPGViewController

- (IBAction)userDoneEnteringText:(UITextField *)aSender
{
  [[aSender.superview.superview viewWithTag:aSender.tag + 1] becomeFirstResponder];
}


#pragma mark - Helper Methods

- (BOOL)textFieldsNotEmpty
{
  return self.emailTextField.text.length != 0 &&
  self.usernameTextField.text.length != 0 &&
  self.passwordTextField.text.length != 0 &&
  self.confirmPasswordTextField.text.length != 0 &&
  self.characterNameTextField.text.length != 0;
}

- (void)fillEmptyAllRegistrationFields
{
  NSString *emptyString = @"";
  self.emailTextField.text = emptyString;
  self.usernameTextField.text = emptyString;
  self.passwordTextField.text = emptyString;
  self.confirmPasswordTextField.text = emptyString;
  self.characterNameTextField.text = emptyString;
}

@end
