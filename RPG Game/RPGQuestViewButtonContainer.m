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
  // Controllers
#import "RPGAlertController+RPGErrorHandling.h"
  // Views
#import "RPGQuestViewController.h"
  // Entities
#import "RPGQuestRequest.h"
#import "RPGQuestReviewRequest.h"
#import "RPGQuest.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"
  // Constants
#import "RPGStatusCodes.h"
#import <AVFoundation/AVFoundation.h>

@interface RPGQuestViewButtonContainer()

@property (nonatomic, assign, readwrite) IBOutlet UIButton *acceptButton;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *denyButton;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *addProofButton;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *getRewardButton;
@end

@implementation RPGQuestViewButtonContainer

#pragma mark - View Update

- (void)updateView
{
  RPGQuestState state = self.questViewController.state;
  
  switch (state)
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
  
  if (state == kRPGQuestStateReviewedTrue && self.questViewController.hasGotReward == NO)
  {
    self.getRewardButton.hidden = NO;
  }
  else
  {
    self.getRewardButton.hidden = YES;
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

- (IBAction)getRewardButtonOnClick:(UIButton *)aSender
{
  __block typeof(self.questViewController) weakQuestViewController = self.questViewController;
  
  RPGQuestRequest *request = [RPGQuestRequest questRequestWithQuestID:self.questViewController.questID];
  [[RPGNetworkManager sharedNetworkManager] getQuestRewardWithRequest:request completionHandler:^void(NSInteger statusCode)
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
         [RPGAlertController showErrorWithStatusCode:kRPGStatusCodeWrongToken completionHandler:^(void)
          {
            dispatch_async(dispatch_get_main_queue(), ^
            {
              UIViewController *viewController = weakQuestViewController.presentingViewController.presentingViewController.presentingViewController;
              [viewController dismissViewControllerAnimated:YES completion:nil];
            });
          }];
         break;
       }
         
       default:
       {
         NSString *message = @"Can't get reward.";
         [RPGAlertController showAlertWithTitle:nil
                                        message:message
                                    actionTitle:nil
                                     completion:nil];
         break;
       }
     }
   }];
}

#pragma mark - Take Quest

- (void)takeQuest
{
  __block typeof(self.questViewController) weakQuestViewController = self.questViewController;
  
  RPGQuestRequest *request = [RPGQuestRequest questRequestWithQuestID:self.questViewController.questID];
  [[RPGNetworkManager sharedNetworkManager] doQuestAction:kRPGQuestActionTakeQuest
                                                  request:request
                                        completionHandler:^void(RPGStatusCode aNetworkStatusCode)
  {
     switch (aNetworkStatusCode)
     {
       case kRPGStatusCodeOK:
       {
         [weakQuestViewController dismissViewControllerAnimated:YES completion:nil];
         break;
       }
         
       case kRPGStatusCodeWrongToken:
       {
         [RPGAlertController showErrorWithStatusCode:kRPGStatusCodeWrongToken completionHandler:^(void)
          {
            dispatch_async(dispatch_get_main_queue(), ^
            {
              UIViewController *viewController = weakQuestViewController.presentingViewController.presentingViewController.presentingViewController;
              [viewController dismissViewControllerAnimated:YES completion:nil];
            });
          }];
         break;
       }
         
       default:
       {
         NSString *message = @"Can't take quest.";
         [RPGAlertController showAlertWithTitle:nil
                                        message:message
                                    actionTitle:nil
                                     completion:nil];
         break;
       }
     }
   }];
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
         
         [RPGAlertController showAlertWithTitle:nil message:message actionTitle:nil completion:nil];
         
       }
     }];
  }
}

#pragma mark - Send Quest Proof

- (void)sendQuestProofWithResult:(BOOL)aResult
{

  __block typeof(self.questViewController) weakQuestViewController = self.questViewController;
  
  RPGQuestReviewRequest *request = [RPGQuestReviewRequest questReviewRequestWithQuestID:self.questViewController.questID result:aResult];
  [[RPGNetworkManager sharedNetworkManager] postQuestProofWithRequest:request
                                                    completionHandler:^void(RPGStatusCode aNetworkStatusCode)
   {
     switch (aNetworkStatusCode)
     {
       case kRPGStatusCodeOK:
       {
         [weakQuestViewController dismissViewControllerAnimated:YES completion:nil];
         break;
       }
         
       case kRPGStatusCodeWrongToken:
       {
         NSString *message = @"Can't send quest proof.\nWrong token error.\nTry to log in again.";
         [RPGAlertController showAlertWithTitle:nil
                                        message:message
                                    actionTitle:nil completion:^(void)
          {
            dispatch_async(dispatch_get_main_queue(), ^
            {
              UIViewController *viewController = weakQuestViewController.presentingViewController.presentingViewController.presentingViewController;
              [viewController dismissViewControllerAnimated:YES completion:nil];
            });
          }];
         break;
       }
         
       default:
       {
         NSString *message = @"Can't send quest proof.";
         [RPGAlertController showAlertWithTitle:nil
                                        message:message
                                    actionTitle:nil
                                     completion:nil];
         break;
       }
     }
   }];
}

@end
