//
//  RPGRegistrationViewController.m
//  RPG Game
//
//  Created by Степан Супинский on 10/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager+Registration.h"
#import "RPGRegistrationViewController.h"
#import "RPGRegistrationRequest.h"
#import "RPGLoginViewController.h"

@interface RPGRegistrationViewController ()

@property (nonatomic, readonly) NSArray *classPickerData;
// Outlets
@property (assign, nonatomic) IBOutlet UILabel *errorLabel;
@property (assign, nonatomic) IBOutlet UIButton *submitButton;
@property (assign, nonatomic) IBOutlet UIPickerView *classPicker;
@property (assign, nonatomic) IBOutlet UITextField *emailTextField;
@property (assign, nonatomic) IBOutlet UITextField *usernameTextField;
@property (assign, nonatomic) IBOutlet UITextField *passwordTextField;
@property (assign, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (assign, nonatomic) IBOutlet UITextField *characterNameTextField;
@property (assign, nonatomic) IBOutlet UIActivityIndicatorView *submitActivityIndicator;

@end

@implementation RPGRegistrationViewController

#pragma mark - Init

- (instancetype)init
{
  self = [super initWithNibName:@"RPGRegistrationViewController"
                         bundle:nil];
  if (self != nil)
  {
    //test data
    _classPickerData = [@[
                          @{ @"className": @"Researcher",
                             @"id": @1
                          }
                        ] retain];
  }
  return self;
}

#pragma mark Dealloc

- (void)dealloc
{
  [_classPickerData release];
  [super dealloc];
}

#pragma mark - View Controller

- (void)viewDidLoad
{
  [super viewDidLoad];
}

#pragma mark UIPickerView data source

// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
  return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
  return self.classPickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
  return self.classPickerData[row][@"className"];
}

#pragma mark Error representation

- (void)showErrorText:(NSString *)text
{
  self.errorLabel.text = text;
  [self.errorLabel setHidden:NO];
  [self.errorLabel sizeToFit];
}

#pragma mark Changing UI state

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

- (NSInteger)getSelectedClassID
{
  NSInteger selectedClassIndex = [self.classPicker selectedRowInComponent:0];
  
  return [self.classPickerData[selectedClassIndex][@"id"] integerValue];
}

#pragma mark Actions

- (IBAction)submitButtonAction:(UIButton *)sender
{
  NSString *emailFieldText = self.emailTextField.text;
  NSString *usernameFieldText = self.usernameTextField.text;
  NSString *passwordFieldText = self.passwordTextField.text;
  NSString *confirmPasswordFieldText = self.confirmPasswordTextField.text;
  NSString *characterNameFieldText = self.characterNameTextField.text;
  NSInteger selectedClassID = [self getSelectedClassID];
  
  if (!([emailFieldText isEqualToString:@""]
        && [usernameFieldText isEqualToString:@""]
        && [passwordFieldText isEqualToString:@""]
        && [confirmPasswordFieldText isEqualToString:@""]
        && [characterNameFieldText isEqualToString:@""]))
  {
    if ([passwordFieldText isEqualToString:confirmPasswordFieldText])
    {
      [self setViewToWaitingForServerResponseState];
      
      RPGRegistrationRequest *registrationRequest = [[[RPGRegistrationRequest alloc] initWithEmail:emailFieldText
                                                                                          password:passwordFieldText
                                                                                          username:usernameFieldText
                                                                                     characterName:characterNameFieldText
                                                                                     characterType:selectedClassID]
                                                     autorelease];
      
      [[RPGNetworkManager sharedNetworkManager] registerWithRequest:registrationRequest
                                                  completionHandler:^(NSInteger statusCode)
       {
         [self setViewToNormalState];
         BOOL success = (statusCode == 0);
         if (success)
         {
           RPGLoginViewController *loginViewController = [[[RPGLoginViewController alloc] init]
                                                          autorelease];
           [self presentViewController:loginViewController
                              animated:YES
                            completion:nil];
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

@end
