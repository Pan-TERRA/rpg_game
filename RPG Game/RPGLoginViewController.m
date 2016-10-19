//
//  RPGLoginViewController.m
//  RPG Game
//
//  Created by Степан Супинский on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGLoginViewController.h"
#import "RPGNetworkManager+Authorization.h"

@interface RPGLoginViewController ()

@property (assign, nonatomic) IBOutlet UILabel *errorMessageLabel;

@property (assign, nonatomic) IBOutlet UITextField *emailInputField;
@property (assign, nonatomic) IBOutlet UITextField *passwordInputField;

@end

@implementation RPGLoginViewController

#pragma mark - Init/dealloc

- (instancetype)init
{
  return [super initWithNibName:@"RPGLoginViewController"
                         bundle:nil];
}

- (void)dealloc
{
  [super dealloc];
}

#pragma mark - View Controller

- (void)viewDidLoad
{
  [super viewDidLoad];
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

- (IBAction)loginAction:(UIButton *)sender
{
  NSString *email = self.emailInputField.text;
  NSString *password = self.passwordInputField.text;
  
  if (email && password &&
      ![email isEqualToString:@""] &&
      ![password isEqualToString:@""])
  {
    RPGAuthorizationLoginRequest *request = [RPGAuthorizationLoginRequest
                                             authorizationRequestWithEmail:email
                                             password:password];
    
    [[RPGNetworkManager sharedNetworkManager] loginWithRequest:request
                                             completionHandler:^(NSInteger statusCode)
     {
       // TODO: Proper response status check
       BOOL success = (statusCode == 0);
        // TODO: add switch
       if (!success)
       {
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
