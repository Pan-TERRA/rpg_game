//
//  RPGQuestViewBodyContainer.m
//  RPG Game
//
//  Created by Максим Шульга on 11/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestViewBodyContainer.h"

#import "RPGQuestViewController.h"
#import "RPGQuestProofImageViewController.h"
#import "RPGStatusCodes.h"
#import "NSUserDefaults+RPGSessionInfo.h"
#import "RPGNetworkManager+Quests.h"
#import "RPGQuestRequest.h"
#import "RPGQuest.h"
#import "RPGAlert.h"

@interface RPGQuestViewBodyContainer()

@property (nonatomic, assign, readwrite) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *descriptionLabel;

@property (nonatomic, retain, readwrite) IBOutlet UILabel *proofLabel;
@property (nonatomic, retain, readwrite) IBOutlet UIImageView *proofImageView;

@end

@implementation RPGQuestViewBodyContainer

#pragma mark - Custom Setter

- (void)setQuestViewController:(RPGQuestViewController *)questViewController
{
  _questViewController = questViewController;
  if (_questViewController != nil)
  {
  
    UITapGestureRecognizer *tapGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture)] autorelease];
    tapGesture.numberOfTapsRequired = 1;
    [self.proofImageView setUserInteractionEnabled:YES];
    [self.proofImageView addGestureRecognizer:tapGesture];
  }
}

#pragma mark - View Content

- (void)setViewContent:(RPGQuest *)aQuest
{
  self.titleLabel.text = aQuest.name;
  self.descriptionLabel.text = aQuest.questDescription;
  

}


#pragma mark - View State

- (void)updateView
{
  switch (self.questViewController.state)
  {
    case kRPGQuestStateCanTake:
    case kRPGQuestStateInProgress:
    
    {
      [self setProofItemsHidden:YES];
      break;
    }
    case kRPGQuestStateForReview:
    case kRPGQuestStateReviewedTrue:
    case kRPGQuestStateDone:
    case kRPGQuestStateReviewedFalse:
    {
      [self setProofItemsHidden:NO];
      break;
    }
  }
}

- (void)setProofItemsHidden:(BOOL)aFlag
{
  //self.proofLabel.hidden = aFlag;
  //self.proofImageView.hidden = aFlag;
  UILabel *proofLabel = self.proofLabel;
  UIImageView *proofImageView = self.proofImageView;
  UILabel *descriptionLabel = self.descriptionLabel;
  UIView *superView = descriptionLabel.superview;
  if (aFlag)
  {
    [proofImageView removeConstraint:[NSLayoutConstraint constraintWithItem:proofImageView
                                                                  attribute:NSLayoutAttributeBottom
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:proofImageView.superview
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0
                                                                   constant:0]];
    [proofImageView removeConstraint:[NSLayoutConstraint constraintWithItem:proofImageView
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:proofLabel
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0
                                                                   constant:5]];
    [proofImageView removeFromSuperview];
    [proofLabel removeConstraint:[NSLayoutConstraint constraintWithItem:proofLabel
                                                                   attribute:NSLayoutAttributeTop
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:descriptionLabel
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1.0
                                                                    constant:10]];
    
    [proofLabel removeFromSuperview];
    [descriptionLabel.superview addConstraint:[NSLayoutConstraint constraintWithItem:descriptionLabel.superview
                                                                             attribute:NSLayoutAttributeBottom
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:descriptionLabel
                                                                             attribute:NSLayoutAttributeBottom
                                                                            multiplier:1.0
                                                                              constant:0]];
  }
}

#pragma mark - Open QuestProofImageView

- (void)handleTapGesture
{
  RPGQuestProofImageViewController *questProofImageViewController = [[RPGQuestProofImageViewController alloc] init];
  [self.questViewController presentViewController:questProofImageViewController animated:YES completion:nil];
  [questProofImageViewController setImage:self.proofImageView.image];
  [questProofImageViewController release];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)aPicker didFinishPickingMediaWithInfo:(NSDictionary *)anInfo
{
  UIImage *chosenImage = anInfo[UIImagePickerControllerEditedImage];
  // !!!: leak
  __block typeof(self.questViewController) weakQuestViewController = self.questViewController;
  
  void (^handler)(NSInteger) = ^void(NSInteger statusCode)
  {
    switch (statusCode)
    {
      case kRPGStatusCodeOK:
      {
        weakQuestViewController.state = kRPGQuestStateDone;
        //weakSelf.stateLabel.text = kRPGQuestStringStateNotReviewed;
        self.proofImageView.image = chosenImage;
        break;
      }
      case kRPGStatusCodeWrongToken:
      {
        NSString *message = @"Can't upload proof image.\nWrong token error.\nTry to log in again.";
        [RPGAlert showAlertViewControllerWithTitle:@"Error" message:message viewController:weakQuestViewController completion:^(void){
          UIViewController *viewController = weakQuestViewController.presentingViewController.presentingViewController.presentingViewController;
          [viewController dismissViewControllerAnimated:YES completion:nil];
        }];
        break;
      }
      default:
      {
        NSString *message = @"Can't upload proof image.";
        [RPGAlert showAlertViewControllerWithTitle:@"Error" message:message viewController:weakQuestViewController completion:nil];
        break;
      }
    }
  };
  
  NSData *data = UIImagePNGRepresentation(chosenImage);
  NSString *token = [[NSUserDefaults standardUserDefaults] sessionToken];
  RPGQuestRequest *request = [RPGQuestRequest questRequestWithToken:token questID:self.questViewController.questID];
  [[RPGNetworkManager sharedNetworkManager] addProofWithRequest:request imageData:data completionHandler:handler];
  
  [aPicker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)aPicker
{
  //self.addProofButton.enabled = YES;
  [aPicker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Upload Image

- (void)uploadImage
{
  // !!!: SELF not WEAKSELF
  void (^handler)(RPGStatusCode, NSData *) = ^void(RPGStatusCode statusCode, NSData *imageData)
  {
    switch (statusCode)
    {
      case kRPGStatusCodeOK:
      {
        self.proofImageView.image = [UIImage imageWithData:imageData];
        break;
      }
      default:
      {
        NSString *message = @"Can't upload quest proof image.";
        [RPGAlert showAlertViewControllerWithTitle:@"Error" message:message viewController:self.questViewController completion:nil];
        break;
      }
    }
    
  };
  
  NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kRPGNetworkManagerAPIHost, self.questViewController.proofImageStringURL]];
  [[RPGNetworkManager sharedNetworkManager] getImageProofDataFromURL:imageURL completionHandler:handler];
}

@end
