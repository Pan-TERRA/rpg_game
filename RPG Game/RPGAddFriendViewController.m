//
//  RPGAddFriendViewController.m
//  RPG Game
//
//  Created by Владислав Крут on 12/7/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAddFriendViewController.h"
  // API
#import "RPGNetworkManager+Friends.h"
  // Entity
#import "RPGAddFriendRequest.h"
  // Constants
#import "RPGNibNames.h"
  // Misc
#import "RPGAlertController.h"

@interface RPGAddFriendViewController () <UITextFieldDelegate>

@property (nonatomic, assign, readwrite) IBOutlet UITextField *friendNickNameTextField;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *confirmAddFriendButton;

@end

@interface RPGAddFriendViewController ()

@end

@implementation RPGAddFriendViewController

#pragma mark - Init

- (instancetype)init
{
  self = [super initWithNibName:kRPGAddFriendViewControllerNIBName bundle:nil];
  
  if (self != nil)
  {
    
  }
  
  return self;
}

#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  [self.friendNickNameTextField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
  self.friendNickNameTextField.text = @"";
  [super viewWillDisappear:animated];
}

#pragma mark - IBActions

- (IBAction)confirmAddFriend:(UIButton *)sender
{
  NSString *userName = self.friendNickNameTextField.text;
  
  [self addFriendWithUserName:userName];
}

- (IBAction)back:(UIButton *)sender
{
  [self.view removeFromSuperview];
  [self removeFromParentViewController];
}

- (IBAction)editingDidChange:(UITextField *)aSender
{
  if (self.friendNickNameTextField.text.length == 0)
  {
    self.confirmAddFriendButton.enabled = NO;
  }
  else
  {
    self.confirmAddFriendButton.enabled = YES;
  }
}


#pragma mark - Network

- (void)addFriendWithUserName:(NSString *)anUserName
{
  
  RPGAddFriendRequest *request = [RPGAddFriendRequest addFriendRequestWithUserName:anUserName];
  
  __block typeof(self) weakSelf = self;
  
  [[RPGNetworkManager sharedNetworkManager] addPlayerToFriendsWithRequest:request
                                                        completionHandler:^(RPGStatusCode status)
  {
    switch (status)
    {
      case kRPGStatusCodeOK:
      {
        [RPGAlertController showAlertWithTitle:@"Success"
                                       message:@"Request sended"
                                   actionTitle:nil
                                    completion:nil];
        break;
      }
        
      case kRPGStatusCodeWrongJSON:
      {
        [RPGAlertController showAlertWithTitle:@"Error"
                                       message:@"Wrong JSON"
                                   actionTitle:nil
                                    completion:nil];
        break;
      }
        
      case kRPGStatusCodeUserIDCannotBeEqualToFriend:
      {
        [RPGAlertController showAlertWithTitle:@"Error"
                                       message:@"This is You"
                                   actionTitle:nil
                                    completion:nil];
        break;
      }
        
      case kRPGStatusCodeFriendRequestIsAlreadySended:
      {
        [RPGAlertController showAlertWithTitle:@"Error"
                                       message:@"Request already sended"
                                   actionTitle:nil
                                    completion:nil];
        break;
      }
        
      case kRPGStatusCodeUserNotFound:
      {
        [RPGAlertController showAlertWithTitle:@"Error"
                                       message:@"User not found"
                                   actionTitle:nil
                                    completion:nil];
        break;
      }
        
      case kRPGStatusCodeWrongToken:
      {
        NSString *message = @"Can't update quest list.\nWrong token error.\nTry to log in again.";
        [RPGAlertController showAlertWithTitle:nil
                                       message:message
                                   actionTitle:nil
                                    completion:^(void)
         {
           dispatch_async(dispatch_get_main_queue(), ^
            {
              UIViewController *viewController = weakSelf.presentingViewController.presentingViewController;
              [viewController dismissViewControllerAnimated:YES completion:nil];
            });
         }];
        break;
      }
        
      default:
      {
        [RPGAlertController showAlertWithTitle:@"Error"
                                       message:@"Can't add friend"
                                   actionTitle:nil
                                    completion:nil];
        break;
      }
    }
    [weakSelf.delegate friendDidAdd:self];
    
    [weakSelf.view removeFromSuperview];
    [weakSelf removeFromParentViewController];
  }];
}

@end
