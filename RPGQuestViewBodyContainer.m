//
//  RPGQuestViewBodyContainer.m
//  RPG Game
//
//  Created by Максим Шульга on 11/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestViewBodyContainer.h"
  // API
#import "RPGNetworkManager+Quests.h"
  // View
#import "RPGQuestViewController.h"
#import "RPGQuestProofImageViewController.h"
  // Entitites
#import "RPGQuest.h"
#import "RPGQuestRequest.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"
#import "RPGAlertController+RPGErrorHandling.h"
  // Constants
#import "RPGStatusCodes.h"

@interface RPGQuestViewBodyContainer()

@property (nonatomic, assign, readwrite) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *descriptionLabel;

@property (nonatomic, retain, readwrite) IBOutlet UILabel *proofLabel;
@property (nonatomic, retain, readwrite) IBOutlet UIImageView *proofImageView;

@property (nonatomic, retain, readwrite) IBOutlet UIActivityIndicatorView *indicatorView;

@property (nonatomic, retain, readwrite) NSLayoutConstraint *descriptionBottomConstraint;

@property (nonatomic, assign, readwrite, getter=shouldDownloadImageProof) BOOL downloadImageProof;

@end

@implementation RPGQuestViewBodyContainer

#pragma mark - Dealloc

- (void)dealloc
{
  [_proofLabel release];
  [_proofImageView release];
  [_descriptionBottomConstraint release];
  
  [super dealloc];
}

#pragma mark - Custom Getter

- (NSLayoutConstraint *)descriptionBottomConstraint
{
  if (_descriptionBottomConstraint == nil)
  {
    _descriptionBottomConstraint = [[NSLayoutConstraint constraintWithItem:self.descriptionLabel.superview
                                                                 attribute:NSLayoutAttributeBottom
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.descriptionLabel
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:0] retain];
  }
  return _descriptionBottomConstraint;
}

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
  self.downloadImageProof = YES;
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
  UILabel *proofLabel = self.proofLabel;
  UIImageView *proofImageView = self.proofImageView;
  UILabel *descriptionLabel = self.descriptionLabel;
  UIActivityIndicatorView *indicatorView = self.indicatorView;
  UIView *superview = descriptionLabel.superview;
  
  if (aFlag)
  {
    [proofImageView removeFromSuperview];
    [proofLabel removeFromSuperview];
    [indicatorView removeFromSuperview];
    [superview addConstraint:self.descriptionBottomConstraint];
  }
  else
  {
    NSArray *subviews = superview.subviews;
    if (![subviews containsObject:proofImageView] && ![subviews containsObject:proofLabel])
    {
      [superview removeConstraint:self.descriptionBottomConstraint];
      
      [superview addSubview:proofLabel];
      [superview addSubview:proofImageView];
      [superview addSubview:indicatorView];
      
      [superview addConstraint:[NSLayoutConstraint constraintWithItem:superview
                                                            attribute:NSLayoutAttributeBottom
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:proofImageView
                                                            attribute:NSLayoutAttributeBottom
                                                           multiplier:1.0
                                                             constant:0]];
      [superview addConstraint:[NSLayoutConstraint constraintWithItem:proofImageView
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:proofLabel
                                                            attribute:NSLayoutAttributeBottom
                                                           multiplier:1.0
                                                             constant:5]];
      [superview addConstraint:[NSLayoutConstraint constraintWithItem:proofLabel
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:descriptionLabel
                                                            attribute:NSLayoutAttributeBottom
                                                           multiplier:1.0
                                                             constant:10]];
      [superview addConstraint:[NSLayoutConstraint constraintWithItem:proofLabel
                                                            attribute:NSLayoutAttributeLeading
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:descriptionLabel
                                                            attribute:NSLayoutAttributeLeading
                                                           multiplier:1.0
                                                             constant:0]];
      [superview addConstraint:[NSLayoutConstraint constraintWithItem:proofImageView
                                                            attribute:NSLayoutAttributeLeading
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:descriptionLabel
                                                            attribute:NSLayoutAttributeLeading
                                                           multiplier:1.0
                                                             constant:0]];
      [superview addConstraint:[NSLayoutConstraint constraintWithItem:indicatorView
                                                            attribute:NSLayoutAttributeLeading
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:proofImageView
                                                            attribute:NSLayoutAttributeLeading
                                                           multiplier:1.0
                                                             constant:0]];
      [superview addConstraint:[NSLayoutConstraint constraintWithItem:indicatorView
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:proofImageView
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1.0
                                                             constant:0]];
    }
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
  [aPicker dismissViewControllerAnimated:YES completion:NULL];
  self.questViewController.state = kRPGQuestStateDone;
  [self setViewToWaitingState];
  
  UIImage *chosenImage = anInfo[UIImagePickerControllerOriginalImage];
  // !!!: leak
  __block typeof(self.questViewController) weakQuestViewController = self.questViewController;
  
  void (^handler)(NSInteger) = ^void(NSInteger statusCode)
  {
    [self setViewToNormalState];
    
    switch (statusCode)
    {
      case kRPGStatusCodeOK:
      {
        self.proofImageView.image = chosenImage;
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
        self.questViewController.state = kRPGQuestStateInProgress;
        NSString *message = @"Can't upload proof image.";
        [RPGAlertController showAlertWithTitle:nil
                                       message:message
                                   actionTitle:nil
                                    completion:nil];
        break;
      }
    }
  };
  
  NSData *data = UIImageJPEGRepresentation(chosenImage, 0.7);
  RPGQuestRequest *request = [RPGQuestRequest questRequestWithQuestID:self.questViewController.questID];
  [[RPGNetworkManager sharedNetworkManager] addProofWithRequest:request imageData:data completionHandler:handler];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)aPicker
{
  //self.addProofButton.enabled = YES;
  [aPicker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Upload Image

- (void)downloadImage
{
  if (self.shouldDownloadImageProof)
  {
    [self setViewToWaitingState];
    // !!!: SELF not WEAKSELF
    void (^handler)(RPGStatusCode, NSData *) = ^void(NSInteger aStatusCode, NSData *anImageData)
    {
      [self setViewToNormalState];
      
      switch (aStatusCode)
      {
        case kRPGStatusCodeOK:
        {
          self.proofImageView.image = [UIImage imageWithData:anImageData];
          self.downloadImageProof = NO;
          break;
        }
          
        default:
        {
          NSString *message = @"Can't download quest proof image.";
          [RPGAlertController showAlertWithTitle:nil
                                         message:message
                                     actionTitle:nil
                                      completion:nil];
          break;
        }
      }
    };
    
    [[RPGNetworkManager sharedNetworkManager] getImageDataFromPath:self.questViewController.proofImageStringURL
                                                 completionHandler:handler];
  }
}

- (void)setViewToWaitingState
{
  self.indicatorView.hidden = NO;
  [self.indicatorView startAnimating];
}

- (void)setViewToNormalState
{
  self.indicatorView.hidden = YES;
  [self.indicatorView stopAnimating];
}

@end
