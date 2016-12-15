//
//  RPGBodyQuestViewController.m
//  RPG Game
//
//  Created by Максим Шульга on 12/15/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBodyQuestViewController.h"
  // API
#import "RPGNetworkManager+Quests.h"
  // Views
#import "RPGQuestViewController.h"
#import "RPGQuestProofImageViewController.h"
  // Entitites
#import "RPGDuelQuest.h"
#import "RPGDuelQuestRequest.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"
#import "RPGAlertController+RPGErrorHandling.h"
  // Constants
#import "RPGStatusCodes.h"
#import "RPGNibNames.h"

@interface RPGBodyQuestViewController ()

@property (nonatomic, assign, readwrite) RPGQuestViewController *questViewController;

@property (nonatomic, assign, readwrite) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *descriptionLabel;

@property (nonatomic, retain, readwrite) IBOutlet UILabel *proofLabel1;
@property (nonatomic, retain, readwrite) IBOutlet UIImageView *proofImageView1;
@property (nonatomic, retain, readwrite) IBOutlet UIActivityIndicatorView *proofIndicatorView1;

@property (nonatomic, assign, readwrite) IBOutlet UILabel *proofLabel2;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *proofImageView2;
@property (nonatomic, assign, readwrite) IBOutlet UIActivityIndicatorView *proofIndicatorView2;

@property (nonatomic, assign, readwrite) IBOutlet UILabel *daysLeftLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *countDaysLeftLabel;
@property (nonatomic, retain, readwrite) NSLayoutConstraint *descriptionBottomConstraint;

@property (nonatomic, assign, readwrite, getter=shouldDownloadImageProof) BOOL downloadImageProof;

@end

@implementation RPGBodyQuestViewController

- (instancetype)initWithQuestViewController:(RPGQuestViewController *)aViewController
{
  self = [super initWithNibName:kRPGBodyQuestViewControllerNIBName
                         bundle:nil];
  
  if (self != nil)
  {
    _questViewController = aViewController;
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_proofLabel1 release];
  [_proofImageView1 release];
  [_proofIndicatorView1 release];
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

#pragma mark - View Content

- (void)setViewContent:(RPGQuest *)aQuest
{
  NSString *questTitle = aQuest.name;
  RPGQuestState state = aQuest.state;
  RPGQuestType type = aQuest.questType;
  RPGDuelQuest *duelQuest = ((RPGDuelQuest *)aQuest);
  
  self.descriptionLabel.text = aQuest.questDescription;
  self.downloadImageProof = YES;
  
  if (type == kRPGQuestTypeDuel
     && state != kRPGQuestStateForReview)
  {
    questTitle = [NSString stringWithFormat:@"%@ with %@", questTitle, duelQuest.friendUsername];
    
    if (state == kRPGQuestStateReviewedTrue)
    {
      NSString *winner = duelQuest.isWinner ? [NSUserDefaults standardUserDefaults].characterNickName : duelQuest.friendUsername;
      questTitle = [NSString stringWithFormat:@"%@. Winner is %@", questTitle, winner];
    }
  }
  
  self.titleLabel.text = questTitle;
  
  if (type == kRPGQuestTypeDuel
      && state == kRPGQuestStateInProgress)
  {
    self.countDaysLeftLabel.text = [NSString stringWithFormat:@"%ld", (long)duelQuest.daysLeft];
  }
  else
  {
    [self.daysLeftLabel removeFromSuperview];
    [self.countDaysLeftLabel removeFromSuperview];
  }
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
  UILabel *proofLabel1 = self.proofLabel1;
  UIImageView *proofImageView1 = self.proofImageView1;
  UIActivityIndicatorView *proofIndicatorView1 = self.proofIndicatorView1;
  UILabel *descriptionLabel = self.descriptionLabel;
  UIView *superview = descriptionLabel.superview;
  
  if (aFlag)
  {
    if (!self.questViewController.didMadeProof)
    {
      [proofImageView1 removeFromSuperview];
      [proofLabel1 removeFromSuperview];
      [proofIndicatorView1 removeFromSuperview];
      [superview addConstraint:self.descriptionBottomConstraint];
    }
    [self setHiddenSecondProofViews];
  }
  else
  {
    if (self.questViewController.questType == kRPGQuestTypeSingle)
    {
      [self setHiddenSecondProofViews];
    }
    
    NSArray *subviews = superview.subviews;
    if (![subviews containsObject:proofImageView1]
        && ![subviews containsObject:proofLabel1]
        && ![subviews containsObject:proofIndicatorView1])
    {
      [superview removeConstraint:self.descriptionBottomConstraint];
      
      [superview addSubview:proofLabel1];
      [superview addSubview:proofImageView1];
      [superview addSubview:proofIndicatorView1];
      
      [superview addConstraint:[NSLayoutConstraint constraintWithItem:superview
                                                            attribute:NSLayoutAttributeBottom
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:proofImageView1
                                                            attribute:NSLayoutAttributeBottom
                                                           multiplier:1.0
                                                             constant:0]];
      [superview addConstraint:[NSLayoutConstraint constraintWithItem:proofImageView1
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:proofLabel1
                                                            attribute:NSLayoutAttributeBottom
                                                           multiplier:1.0
                                                             constant:5]];
      [superview addConstraint:[NSLayoutConstraint constraintWithItem:proofLabel1
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:descriptionLabel
                                                            attribute:NSLayoutAttributeBottom
                                                           multiplier:1.0
                                                             constant:10]];
      [superview addConstraint:[NSLayoutConstraint constraintWithItem:proofLabel1
                                                            attribute:NSLayoutAttributeLeading
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:descriptionLabel
                                                            attribute:NSLayoutAttributeLeading
                                                           multiplier:1.0
                                                             constant:0]];
      [superview addConstraint:[NSLayoutConstraint constraintWithItem:proofImageView1
                                                            attribute:NSLayoutAttributeLeading
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:descriptionLabel
                                                            attribute:NSLayoutAttributeLeading
                                                           multiplier:1.0
                                                             constant:0]];
      [superview addConstraint:[NSLayoutConstraint constraintWithItem:proofIndicatorView1
                                                            attribute:NSLayoutAttributeLeading
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:proofImageView1
                                                            attribute:NSLayoutAttributeLeading
                                                           multiplier:1.0
                                                             constant:0]];
      [superview addConstraint:[NSLayoutConstraint constraintWithItem:proofIndicatorView1
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:proofImageView1
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1.0
                                                             constant:0]];
    }
  }
}

- (void)setHiddenSecondProofViews
{
  self.proofLabel2.hidden = YES;
  self.proofImageView2.hidden = YES;
  self.proofIndicatorView2.hidden = YES;
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)aPicker didFinishPickingMediaWithInfo:(NSDictionary *)anInfo
{
  [aPicker dismissViewControllerAnimated:YES
                              completion:NULL];
  
  self.questViewController.state = kRPGQuestStateDone;
  [self setIndicatorViewToWaitingState:self.proofIndicatorView1];
  
  UIImage *chosenImage = anInfo[UIImagePickerControllerOriginalImage];
  // !!!: leak
  __block typeof(self.questViewController) weakQuestViewController = self.questViewController;
  
  NSData *data = UIImageJPEGRepresentation(chosenImage, 0.7);
  RPGQuestRequest *request = nil;
  RPGQuestViewController *questViewController = self.questViewController;
  RPGQuestType questType = questViewController.questType;
  
  switch (questType)
  {
    case kRPGQuestTypeSingle:
    {
      request = [RPGQuestRequest questRequestWithQuestID:questViewController.questID];
      break;
    }
      
    case kRPGQuestTypeDuel:
    {
      request = [RPGDuelQuestRequest duelQuestRequestWithQuestID:questViewController.questID
                                                        friendID:questViewController.duelQuestFriendID];
      break;
    }
  }
  
  [[RPGNetworkManager sharedNetworkManager] addProofByType:questType
                                                   request:request
                                                 imageData:data
                                         completionHandler:^void(RPGStatusCode aNetworkStatusCode)
   {
     [self setIndicatorViewToNormalState:self.proofIndicatorView1];
     
     switch (aNetworkStatusCode)
     {
       case kRPGStatusCodeOK:
       {
         self.proofImageView1.image = chosenImage;
         self.questViewController.makeProof = YES;
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
         self.questViewController.state = kRPGQuestStateInProgress;
         
         NSString *message = @"Can't upload proof image.";
         [RPGAlertController showAlertWithTitle:nil
                                        message:message
                                    actionTitle:nil
                                     completion:nil];
         break;
       }
     }
   }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)aPicker
{
  [aPicker dismissViewControllerAnimated:YES
                              completion:NULL];
}

#pragma mark - Upload Image

- (void)downloadImage:(NSString *)aStringURL
            imageView:(UIImageView *)anImageView
{
  if (self.shouldDownloadImageProof)
  {
    UIActivityIndicatorView *indicatorView = nil;
    
    if (anImageView == self.proofImageView1)
    {
      indicatorView = self.proofIndicatorView1;
    }
    else if (anImageView == self.proofImageView2)
    {
      indicatorView = self.proofIndicatorView2;
    }
    
    [self setIndicatorViewToWaitingState:indicatorView];
    // !!!: SELF not WEAKSELF
    
    [[RPGNetworkManager sharedNetworkManager] getImageDataFromPath:aStringURL
                                                 completionHandler:^void(RPGStatusCode aNetworkStatusCode,
                                                                         NSData *anImageData)
     {
       [self setIndicatorViewToNormalState:indicatorView];
       
       switch (aNetworkStatusCode)
       {
         case kRPGStatusCodeOK:
         {
           anImageView.image = [UIImage imageWithData:anImageData];
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
     }];
  }
}

#pragma mark - UIActivityIndicatorView State

- (void)setIndicatorViewToWaitingState:(UIActivityIndicatorView *)anIndicatorView
{
  anIndicatorView.hidden = NO;
  [anIndicatorView startAnimating];
}

- (void)setIndicatorViewToNormalState:(UIActivityIndicatorView *)anIndicatorView
{
  anIndicatorView.hidden = YES;
  [anIndicatorView stopAnimating];
}

@end
