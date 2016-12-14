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
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"
  // Constants
#import "RPGStatusCodes.h"
#import "RPGQuestEnum.h"
#import <AVFoundation/AVFoundation.h>

@interface RPGQuestViewButtonContainer()

@property (nonatomic, assign, readwrite) IBOutlet UIButton *acceptButton1;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *acceptButton2;
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
  
  BOOL hiddenFlag = (state == kRPGQuestStateReviewedTrue && self.questViewController.hasGotReward == NO);
  self.getRewardButton.hidden = !hiddenFlag;
}

#pragma mark - View State

- (void)setStateTakeOrInProgressQuest:(BOOL)aFlag
{
  self.acceptButton1.hidden = !aFlag;
  self.acceptButton2.hidden = !aFlag;
  self.denyButton.hidden = YES;
  self.addProofButton.hidden = aFlag;
}

- (void)setStateReviewedQuest:(BOOL)aFlag
{
  self.acceptButton1.hidden = YES;
  self.acceptButton2.hidden = YES;
  self.denyButton.hidden = YES;
  self.addProofButton.hidden = aFlag;
}

- (void)setStateForReviewQuest
{
  BOOL aFlag = (self.questViewController.questType == kRPGQuestTypeDuel);
  self.acceptButton1.hidden = NO;
  self.acceptButton2.hidden = aFlag;
  self.denyButton.hidden = !aFlag;
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
    BOOL result = YES;
    
    if (self.questViewController.questType == kRPGQuestTypeDuel
        && aSender == self.acceptButton1)
    {
      result = NO;
    }
    
    [self sendQuestProofWithResult:result];
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
  [self.questViewController dismissViewControllerAnimated:YES
                                               completion:nil];
}

- (IBAction)getRewardButtonOnClick:(UIButton *)aSender
{
  __block typeof(self.questViewController) weakQuestViewController = self.questViewController;
  RPGQuestRequest *request = [RPGQuestRequest questRequestWithQuestID:self.questViewController.questID];
  
  [[RPGNetworkManager sharedNetworkManager] getQuestRewardWithRequest:request
                                                    completionHandler:^void(NSInteger statusCode)
   {
     switch (statusCode)
     {
       case kRPGStatusCodeOK:
       {
         [weakQuestViewController dismissViewControllerAnimated:YES
                                                     completion:nil];
         break;
       }
         
       case kRPGStatusCodeWrongToken:
       {
         [RPGAlertController showErrorWithStatusCode:kRPGStatusCodeWrongToken
                                   completionHandler:^(void)
          {
            dispatch_async(dispatch_get_main_queue(), ^
            {
              UIViewController *viewController = weakQuestViewController.presentingViewController.presentingViewController.presentingViewController;
              [viewController dismissViewControllerAnimated:YES
                                                 completion:nil];
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
                                                   byType:kRPGQuestTypeSingle
                                                  request:request
                                        completionHandler:^void(RPGStatusCode aNetworkStatusCode)
  {
     switch (aNetworkStatusCode)
     {
       case kRPGStatusCodeOK:
       {
         [weakQuestViewController dismissViewControllerAnimated:YES
                                                     completion:nil];
         break;
       }
         
       case kRPGStatusCodeWrongToken:
       {
         [RPGAlertController showErrorWithStatusCode:kRPGStatusCodeWrongToken
                                   completionHandler:^(void)
          {
            dispatch_async(dispatch_get_main_queue(), ^
            {
              UIViewController *viewController = weakQuestViewController.presentingViewController.presentingViewController.presentingViewController;
              [viewController dismissViewControllerAnimated:YES
                                                 completion:nil];
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
  if ([AVCaptureDevice respondsToSelector:@selector(requestAccessForMediaType:completionHandler:)])
  {
    __block typeof(self.questViewController) weakQuestViewController = self.questViewController;
    
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo
                             completionHandler:^(BOOL granted)
     {
       if (granted)
       {
         if (weakQuestViewController.imagePickerController)
         {
           dispatch_async(dispatch_get_main_queue(), ^
           {
             [weakQuestViewController presentViewController:weakQuestViewController.imagePickerController
                                                   animated:NO
                                                 completion:nil];
           });
         }
       }
       else
       {
         NSString *message = @"Give this app permission to access your camera in your settings app!";
         [RPGAlertController showAlertWithTitle:nil
                                        message:message
                                    actionTitle:nil
                                     completion:nil];
       }
     }];
  }
}

#pragma mark - Send Quest Proof

- (void)sendQuestProofWithResult:(BOOL)aResult
{
  __block typeof(self.questViewController) weakQuestViewController = self.questViewController;
  RPGQuestReviewRequest *request = [RPGQuestReviewRequest questReviewRequestWithQuestID:self.questViewController.questID
                                                                                 result:aResult];
  
  [[RPGNetworkManager sharedNetworkManager] postQuestProofWithRequest:request
                                                    completionHandler:^void(RPGStatusCode aNetworkStatusCode)
   {
     switch (aNetworkStatusCode)
     {
       case kRPGStatusCodeOK:
       {
         [weakQuestViewController dismissViewControllerAnimated:YES
                                                     completion:nil];
         break;
       }
         
       case kRPGStatusCodeWrongToken:
       {
         NSString *message = @"Can't send quest proof.\nWrong token error.\nTry to log in again.";
         [RPGAlertController showAlertWithTitle:nil
                                        message:message
                                    actionTitle:nil
                                     completion:^(void)
          {
            dispatch_async(dispatch_get_main_queue(), ^
            {
              UIViewController *viewController = weakQuestViewController.presentingViewController.presentingViewController.presentingViewController;
              [viewController dismissViewControllerAnimated:YES
                                                 completion:nil];
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
