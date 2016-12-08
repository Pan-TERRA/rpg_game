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
#import "RPGNetworkManager+Authorization.h"
#import "RPGNetworkManager+Classes.h"
  // Controllers
#import "RPGAlertController+RPGErrorHandling.h"
#import "RPGCollectionViewController.h"
#import "RPGAvatarCollectionViewController.h"
  // Views
#import "RPGLoginViewController.h"
#import "RPGMainViewController.h"
  // Entities
#import "RPGRegistrationRequest.h"
#import "RPGAuthorizationLoginRequest.h"
#import "RPGClassInfoRepresentation.h"
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
@property (nonatomic, assign, readwrite) IBOutlet UICollectionView *avatarCollectionView;
@property (nonatomic, retain, readwrite) RPGAvatarCollectionViewController *avatarCollectionViewController;

@property (nonatomic, assign, readwrite) IBOutlet UIActivityIndicatorView *submitActivityIndicator;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *submitButton;

@property (nonatomic, retain, readwrite) RPGClassInfoRepresentation *classInfo;

@end

@implementation RPGRegistrationViewController

#pragma mark - Init

- (instancetype)init
{
  self = [super initWithNibName:kRPGRegistrationViewControllerNIBName bundle:nil];
  
  if (self != nil)
  {
    _classInfo = [[RPGClassInfoRepresentation alloc] init];
    _classPickerData = [[NSArray alloc] init];
    _avatarCollectionViewController = [[RPGAvatarCollectionViewController alloc] init];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_classPickerData release];
  [_avatarCollectionViewController release];
  [_classInfo release];
  [[NSNotificationCenter defaultCenter] removeObserver:self];

  [super dealloc];
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
  return self.classPickerData[aRow];
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
  [self updateAvatarCollection];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.classPickerData = self.classInfo.classNames;
  
  UINib *cellNIB = [UINib nibWithNibName:kRPGAvatarCollectionViewCellNIBName bundle:nil];
  [self.avatarCollectionView registerNib:cellNIB forCellWithReuseIdentifier:kRPGAvatarCollectionViewCellNIBName];
  self.avatarCollectionViewController = [[[RPGAvatarCollectionViewController alloc] initWithCollectionView:self.avatarCollectionView
                                                                                      parentViewController:self
                                                                                       selectedAvatarIndex:0] autorelease];
  [self updateAvatarCollection];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  return UIInterfaceOrientationMaskLandscape;
}

#pragma mark - View State

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

#pragma mark - IBActions

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
  NSInteger classNameIndex = [self.classPicker selectedRowInComponent:0];
  NSInteger selectedClassID = [self.classInfo classIDByName:self.classPickerData[classNameIndex]];
  NSInteger selectedAvatarIndex = self.avatarCollectionViewController.selectedAvatarIndex + 1;
  
  if ([self textFieldsNotEmpty])
  {
    if ([passwordFieldText isEqualToString:confirmPasswordFieldText])
    {
      [self setViewToWaitingForServerResponseState];
      
      RPGRegistrationRequest *registrationRequest = [RPGRegistrationRequest registrationRequestWithEmail:emailFieldText
                                                                                                password:passwordFieldText
                                                                                                username:usernameFieldText
                                                                                           characterName:characterNameFieldText
                                                                                           characterType:selectedClassID
                                                                                                avatarID:selectedAvatarIndex];
      
      [[RPGNetworkManager sharedNetworkManager] registerWithRequest:registrationRequest
                                                  completionHandler:^(NSInteger statusCode)
       {
         [self setViewToNormalState];
         
         switch (statusCode)
         {
           case kRPGStatusCodeOK:
           {
             RPGAuthorizationLoginRequest *loginRequest = [[RPGAuthorizationLoginRequest alloc] initWithEmail:emailFieldText
                                                                                                     password:passwordFieldText];
             [loginRequest autorelease];
             [[RPGNetworkManager sharedNetworkManager] loginWithRequest:loginRequest
                                                      completionHandler:^(NSInteger statusCode)
              {
                switch (statusCode)
                {
                  case kRPGStatusCodeOK:
                  {
                    
                    RPGMainViewController *mainViewController = [[[RPGMainViewController alloc] init] autorelease];
                    [self presentViewController:mainViewController animated:YES completion:nil];
                    break;
                  }
                    
                  default:
                  {
                    [self presentViewController:[[[RPGLoginViewController alloc] init] autorelease]
                                       animated:YES
                                     completion:nil];
                    break;
                  }
                }
              }];
             break;
           }
             
           default:
           {
             if ([self canHandleStatusCode:statusCode])
             {
               [RPGAlertController showErrorWithStatusCode:statusCode
                                         completionHandler:nil];
             }
             else
             {
               [RPGAlertController handleDefaultError];
             }
             break;
           }
         }
       }];
    }
    else
    {
      [self showErrorWithMessage:@"Password doesn't match."];
    }
  }
  else
  {
    [self showErrorWithMessage:@"Please fill in all required fields."];
  }
}

#pragma mark - RPGViewController

- (IBAction)userDoneEnteringText:(UITextField *)aSender
{
  [[aSender.superview.superview viewWithTag:aSender.tag + 1] becomeFirstResponder];
}

#pragma mark - Helper Methods

- (void)showErrorWithMessage:(NSString *)message
{
  [RPGAlertController showAlertWithTitle:nil
                                 message:message
                             actionTitle:nil
                              completion:nil];
}

- (BOOL)textFieldsNotEmpty
{
  return self.emailTextField.text.length != 0 &&
  self.usernameTextField.text.length != 0 &&
  self.passwordTextField.text.length != 0 &&
  self.confirmPasswordTextField.text.length != 0 &&
  self.characterNameTextField.text.length != 0;
}

- (BOOL)canHandleStatusCode:(RPGStatusCode)aStatusCode
{
  return aStatusCode == kRPGStatusCodeWrongEmail
  || aStatusCode == kRPGStatusCodeWrongJSON
  || aStatusCode == kRPGStatusCodeEmailAlreadyTaken
  || aStatusCode == kRPGStatusCodeUsernameAlreadyTaken
  || aStatusCode == kRPGStatusCodeTooShortUsername
  || aStatusCode == kRPGStatusCodeTooLongUsername
  || aStatusCode == kRPGStatusCodeTooShortPassword
  || aStatusCode == kRPGStatusCodeTooLongPassword
  || aStatusCode == kRPGStatusCodeTooShortCharacterName
  || aStatusCode == kRPGStatusCodeTooLongCharacterName
  || aStatusCode == kRPGStatusCodeInvalidUsername
  || aStatusCode == kRPGStatusCodeInvalidCharacterName
  || aStatusCode == kRPGStatusCodeUndefinedSymbolsInUsername
  || aStatusCode == kRPGStatusCodeUndefinedSymbolsInCharacterName;
}

- (void)updateAvatarCollection
{
  NSInteger i = [self.classPicker selectedRowInComponent:0];
  NSString *characterClassName = self.classPickerData[i];
  NSInteger characterClassID = [self.classInfo classIDByName:characterClassName];
  self.avatarCollectionViewController.characterClassID = characterClassID;
}

@end
