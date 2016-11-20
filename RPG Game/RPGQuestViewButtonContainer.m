//
//  RPGQuestViewButtonContainerController.m
//  RPG Game
//
//  Created by Максим Шульга on 11/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestViewButtonContainer.h"
  // API
#import "RPGNetworkManager+Quests.h"
  // Views
#import "RPGQuestViewController.h"
  // Entities
#import "RPGQuestRequest.h"
#import "RPGQuestReviewRequest.h"
#import "RPGQuest.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"
#import "RPGAlertController.h"
  // Constants
#import "RPGStatusCodes.h"

#import <AVFoundation/AVFoundation.h>

@interface RPGQuestViewButtonContainer()

@property (nonatomic, assign, readwrite) IBOutlet UIButton *acceptButton;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *denyButton;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *addProofButton;

@end

@implementation RPGQuestViewButtonContainer

#pragma mark - View Update

- (void)updateView
{
  switch (self.questViewController.state)
  {
    case kRPGQuestStateCanTake:
    {
      [self setStateTakeOrInProgressQuest:YES];
      break;
    }
      
    case kRPGQuestStateInProgress:
    {
      [self setStateTakeOrInProgressQuest:NO];
      break;
    }
      
    case kRPGQuestStateDone:
    {
      [self setStateReviewedQuest:YES];
      break;
    }
      
    case kRPGQuestStateReviewedFalse:
    {
      [self setStateReviewedQuest:NO];
      break;
    }

    case kRPGQuestStateForReview:
    {
      [self setStateForReviewQuest];
      break;
    }
      
    case kRPGQuestStateReviewedTrue:
    {
      [self setStateReviewedQuest:YES];
      break;
    }
  }
}

#pragma mark - View State

- (void)setStateTakeOrInProgressQuest:(BOOL)aFlag
{
  self.acceptButton.hidden = !aFlag;
  self.denyButton.hidden = YES;
  self.addProofButton.hidden = aFlag;
}

- (void)setStateReviewedQuest:(BOOL)aFlag
{
  self.acceptButton.hidden = YES;
  self.denyButton.hidden = YES;
  self.addProofButton.hidden = aFlag;
}

- (void)setStateForReviewQuest
{
  self.acceptButton.hidden = NO;
  self.denyButton.hidden = NO;
  self.addProofButton.hidden = YES;
}

#pragma mark - IBAction

- (IBAction)acceptButtonOnClick:(UIButton *)aSender
{
  RPGQuestState state = self.questViewController.state;
  if (state == kRPGQuestStateCanTake)
  {
    [self takeQuest];
  }
  else if (state == kRPGQuestStateForReview)
  {
    [self sendQuestProofWithResult:YES];
  }
}

- (IBAction)denyButtonOnClick:(UIButton *)aSender
{
  [self sendQuestProofWithResult:NO];
}

- (IBAction)addProofButtonOnClick:(UIButton *)aSender
{
  [self addProofWithCamera];
}

- (IBAction)backButtonOnClick:(UIButton *)aSender
{
  [self.questViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Take Quest

- (void)takeQuest
{
  //self.acceptButton.enabled = NO;
  
  __block typeof(self.questViewController) weakQuestViewController = self.questViewController;
  
  void (^handler)(NSInteger) = ^void(NSInteger statusCode)
  {
    switch (statusCode)
    {
      case kRPGStatusCodeOK:
      {
        [weakQuestViewController dismissViewControllerAnimated:YES completion:nil];
        break;
      }
      case kRPGStatusCodeWrongToken:
      {
        NSString *message = @"Can't take quest.\nWrong token error.\nTry to log in again.";
        [RPGAlertController showAlertWithTitle:@"Error" message:message completion:^(void)
        {
          UIViewController *viewController = weakQuestViewController.presentingViewController.presentingViewController.presentingViewController;
          [viewController dismissViewControllerAnimated:YES completion:nil];
        }];
        break;
      }
      default:
      {
        NSString *message = @"Can't take quest.";
        [RPGAlertController showAlertWithTitle:@"Error" message:message completion:nil];
        break;
      }
    }
    //weakSelf.acceptButton.enabled = YES;
  };
  
  RPGQuestRequest *request = [RPGQuestRequest questRequestWithQuestID:self.questViewController.questID];
  [[RPGNetworkManager sharedNetworkManager] doQuestAction:kRPGQuestActionTakeQuest request:request completionHandler:handler];
}

#pragma mark - Add Proof With Camera

- (void)addProofWithCamera
{
  //self.addProofButton.enabled = NO;
  if ([AVCaptureDevice respondsToSelector:@selector(requestAccessForMediaType:completionHandler:)])
  {
    __block typeof(self.questViewController) weakQuestViewController = self.questViewController;
    
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted)
     {
       if (granted)
       {
         if (weakQuestViewController.imagePickerController)
         {
           dispatch_async(dispatch_get_main_queue(), ^
           {
             [weakQuestViewController presentViewController:weakQuestViewController.imagePickerController animated:NO completion:nil];
             //weakSelf.addProofButton.enabled = YES;
           });
         }
       }
       else
       {
         NSString *message = @"Give this app permission to access your camera in your settings app!";
         dispatch_async(dispatch_get_main_queue(), ^
         {
           [RPGAlertController showAlertWithTitle:@"Error" message:message completion:nil];
           //weakSelf.addProofButton.enabled = YES;
         });
       }
     }];
  }
}

#pragma mark - Send Quest Proof

- (void)sendQuestProofWithResult:(BOOL)aResult
{
  //self.acceptButton.enabled = NO;
  //self.denyButton.enabled = NO;
  
  __block typeof(self.questViewController) weakQuestViewController = self.questViewController;
  
  void (^handler)(NSInteger) = ^void(NSInteger statusCode)
  {
    switch (statusCode)
    {
      case kRPGStatusCodeOK:
      {
        [weakQuestViewController dismissViewControllerAnimated:YES completion:nil];
        break;
      }
      case kRPGStatusCodeWrongToken:
      {
        NSString *message = @"Can't send quest proof.\nWrong token error.\nTry to log in again.";
        [RPGAlertController showAlertWithTitle:@"Error" message:message completion:^(void)
        {
          UIViewController *viewController = weakQuestViewController.presentingViewController.presentingViewController.presentingViewController;
          [viewController dismissViewControllerAnimated:YES completion:nil];
        }];
        break;
      }
      default:
      {
        NSString *message = @"Can't send quest proof.";
        [RPGAlertController showAlertWithTitle:@"Error" message:message completion:nil];
        break;
      }
    }
    //self.acceptButton.enabled = YES;
    //self.denyButton.enabled = YES;
  };
  RPGQuestReviewRequest *request = [RPGQuestReviewRequest questReviewRequestWithQuestID:self.questViewController.questID result:aResult];
  [[RPGNetworkManager sharedNetworkManager] postQuestProofWithRequest:request completionHandler:handler];
}

@end
