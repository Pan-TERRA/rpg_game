//
//  RPGQuestViewController.m
//  RPG Game
//
//  Created by Максим Шульга on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "RPGQuestViewController.h"
  // API
#import "RPGNetworkManager+Quests.h"
  // Views
#import "RPGQuestListViewController.h"
#import "RPGQuestProofImageViewController.h"
  // Entities
#import "RPGQuest+Serialization.h"
#import "RPGQuestReward+Serialization.h"
#import "RPGQuestRequest+Serialization.h"
#import "RPGQuestReviewRequest+Serialization.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"
#import "RPGAlert.h"
  // Constants
#import "RPGNibNames.h"
#import "RPGQuestAction.h"

@interface RPGQuestViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, assign, readwrite) IBOutlet UILabel *proofLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *proofImageView;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *stateTitleLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *stateLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *crystalsRewardLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *goldRewardLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *skillRewardImageView;

@property (nonatomic, assign, readwrite) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *descriptionLabel;

@property (nonatomic, assign, readwrite) IBOutlet UIButton *addProofButton;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *acceptButton;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *denyButton;

@property (nonatomic, assign, readwrite) RPGQuestState state;
@property (nonatomic, assign, readwrite) NSUInteger questID;

@property (nonatomic, copy, readwrite) NSString *proofImageStringURL;
@property (nonatomic, retain, readwrite) UIImagePickerController *imagePickerController;

@end

@implementation RPGQuestViewController

#pragma mark - Init

- (instancetype)init
{
  return [super initWithNibName:kRPGQuestViewControllerNIBName
                         bundle:nil];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_imagePickerController release];
  [_proofImageStringURL release];
  [super dealloc];
}

#pragma mark - Custom Getter

- (UIImagePickerController *)pickerController
{
  if (_imagePickerController == nil)
  {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    _imagePickerController = [picker retain];
  }
  return _imagePickerController;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UITapGestureRecognizer *tapGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture)] autorelease];
  tapGesture.numberOfTapsRequired = 1;
  [self.proofImageView setUserInteractionEnabled:YES];
  [self.proofImageView addGestureRecognizer:tapGesture];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  
  switch (self.state)
  {
    case kRPGQuestStateDone:
    case kRPGQuestStateReviewedFalse:
    case kRPGQuestStateForReview:
    case kRPGQuestStateReviewedTrue:
    {
      if (self.proofImageStringURL != nil)
      {
        [self uploadImage];
      }
      break;
    }
    default:
    {
      break;
    }
  }
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  UIInterfaceOrientationMask mask = UIInterfaceOrientationMaskAll;
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
  {
    mask = UIInterfaceOrientationMaskLandscape;
  }
  return mask;
}

#pragma mark - View Content

- (void)setViewContent:(RPGQuest *)aQuest
{
  self.titleLabel.text = aQuest.name;
  self.descriptionLabel.text = aQuest.questDescription;
  self.crystalsRewardLabel.text = [@(aQuest.reward.crystals) stringValue];
  self.goldRewardLabel.text = [@(aQuest.reward.gold) stringValue];
  if (aQuest.reward.skillID != 0)
  {
    
  }
  else
  {
    self.skillRewardImageView.hidden = YES;
  }
  
  self.state = aQuest.state;
  self.questID = aQuest.questID;
  self.proofImageStringURL = aQuest.proofImageStringURL;
  
  switch (self.state)
  {
    case kRPGQuestStateCanTake:
    {
      [self setStateTakeOrInProgressQuest];
      break;
    }
    case kRPGQuestStateInProgress:
    {
      [self setStateTakeOrInProgressQuest];
      self.stateLabel.text = kRPGQuestStringStateInProgress;
      break;
    }
    case kRPGQuestStateDone:
    {
      [self setStateReviewedQuest:NO];
      self.stateLabel.text = kRPGQuestStringStateNotReviewed;
      break;
    }
    case kRPGQuestStateReviewedFalse:
    {
      [self setStateReviewedQuest:NO];
      self.stateLabel.text = kRPGQuestStringStateReviewedFalse;
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
    default:
    {
      break;
    }
  }
}

#pragma mark - View State

- (void)setStateTakeOrInProgressQuest
{
  self.acceptButton.hidden = !(self.state == kRPGQuestStateCanTake);
  self.denyButton.hidden = YES;
  self.addProofButton.hidden = (self.state == kRPGQuestStateCanTake);
  [self setProofItemsHidden:YES];
  [self setStateItemsHidden:(self.state == kRPGQuestStateCanTake)];
}

- (void)setStateReviewedQuest:(BOOL)aFlag
{
  self.acceptButton.hidden = YES;
  self.denyButton.hidden = YES;
  self.addProofButton.hidden = (self.state != kRPGQuestStateReviewedFalse);
  [self setProofItemsHidden:NO];
  [self setStateItemsHidden:aFlag];
}

- (void)setStateForReviewQuest
{
  self.acceptButton.hidden = NO;
  self.denyButton.hidden = NO;
  self.addProofButton.hidden = YES;
  [self setProofItemsHidden:NO];
  [self setStateItemsHidden:YES];
}

- (void)setProofItemsHidden:(BOOL)aFlag
{
  self.proofLabel.hidden = aFlag;
  self.proofImageView.hidden = aFlag;
}

- (void)setStateItemsHidden:(BOOL)aFlag
{
  self.stateTitleLabel.hidden = aFlag;
  self.stateLabel.hidden = aFlag;
}

#pragma mark - IBAction

- (IBAction)acceptButtonOnClick:(UIButton *)aSender
{
  if (self.state == kRPGQuestStateCanTake)
  {
    [self takeQuest];
  }
  else if (self.state == kRPGQuestStateForReview)
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
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Open QuestProofImageView

- (void)handleTapGesture
{
  RPGQuestProofImageViewController *questProofImageViewController = [[RPGQuestProofImageViewController alloc] init];
  [self presentViewController:questProofImageViewController animated:YES completion:nil];
  [questProofImageViewController setImage:self.proofImageView.image];
  [questProofImageViewController release];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)aPicker didFinishPickingMediaWithInfo:(NSDictionary *)anInfo
{
  UIImage *chosenImage = anInfo[UIImagePickerControllerEditedImage];
  // !!!: leak
  __block typeof(self) weakSelf = self;
  
  void (^handler)(NSInteger) = ^void(NSInteger statusCode)
  {
    switch (statusCode)
    {
      case kRPGStatusCodeOk:
      {
        weakSelf.state = kRPGQuestStateDone;
        [weakSelf setStateReviewedQuest:NO];
        weakSelf.stateLabel.text = kRPGQuestStringStateNotReviewed;
        weakSelf.proofImageView.image = chosenImage;
        break;
      }
      case kRPGStatusCodeWrongToken:
      {
        UIViewController *loginViewController = self.presentingViewController.presentingViewController.presentingViewController;
        [loginViewController dismissViewControllerAnimated:YES completion:nil];
        NSString *message = @"Can't upload proof image.\nWrong token error.\nTry to log in again.";
        [RPGAlert showAlertViewControllerWithTitle:@"Error" message:message viewController:loginViewController completion:nil];
        break;
      }
      default:
      {
        NSString *message = @"Can't upload proof image.";
        [RPGAlert showAlertViewControllerWithTitle:@"Error" message:message viewController:weakSelf completion:nil];
        break;
      }
    }
  };
  
  NSData *data = UIImagePNGRepresentation(chosenImage);
  NSString *token = [[NSUserDefaults standardUserDefaults] sessionToken];
  RPGQuestRequest *request = [RPGQuestRequest questRequestWithToken:token questID:self.questID];
  [[RPGNetworkManager sharedNetworkManager] addProofWithRequest:request imageData:data completionHandler:handler];
  
  [aPicker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)aPicker
{
  self.addProofButton.enabled = YES;
  [aPicker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Take Quest

- (void)takeQuest
{
  self.acceptButton.enabled = NO;
  
  __block typeof(self) weakSelf = self;
  
  void (^handler)(NSInteger) = ^void(NSInteger statusCode)
  {
    switch (statusCode)
    {
      case kRPGStatusCodeOk:
      {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
        break;
      }
      case kRPGStatusCodeWrongToken:
      {
        UIViewController *loginViewController = self.presentingViewController.presentingViewController.presentingViewController;
        [loginViewController dismissViewControllerAnimated:YES completion:nil];
        NSString *message = @"Can't take quest.\nWrong token error.\nTry to log in again.";
        [RPGAlert showAlertViewControllerWithTitle:@"Error" message:message viewController:loginViewController completion:nil];
        break;
      }
      default:
      {
        NSString *message = @"Can't take quest.";
        [RPGAlert showAlertViewControllerWithTitle:@"Error" message:message viewController:weakSelf completion:nil];
        break;
      }
    }
    weakSelf.acceptButton.enabled = YES;
  };
  NSString *token = [[NSUserDefaults standardUserDefaults] sessionToken];
  RPGQuestRequest *request = [RPGQuestRequest questRequestWithToken:token questID:self.questID];
  [[RPGNetworkManager sharedNetworkManager] doQuestAction:kRPGQuestActionTakeQuest request:request completionHandler:handler];
}

#pragma mark - Add Proof With Camera

- (void)addProofWithCamera
{
  self.addProofButton.enabled = NO;
  if ([AVCaptureDevice respondsToSelector:@selector(requestAccessForMediaType:completionHandler:)])
  {
    __block typeof(self) weakSelf = self;
    
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted)
    {
      if (granted)
      {
        if (weakSelf.pickerController)
        {
          dispatch_async(dispatch_get_main_queue(), ^
          {
            [weakSelf presentViewController:weakSelf.pickerController animated:NO completion:nil];
            weakSelf.addProofButton.enabled = YES;
          });
        }
      }
      else
      {
        NSString *message = @"Give this app permission to access your camera in your settings app!";
        dispatch_async(dispatch_get_main_queue(), ^
        {
          [RPGAlert showAlertViewControllerWithTitle:@"Error" message:message viewController:weakSelf completion:nil];
          weakSelf.addProofButton.enabled = YES;
        });
      }
    }];
  }
}

#pragma mark - Upload Image

- (void)uploadImage
{
  // !!!: SELF not WEAKSELF
  void (^handler)(RPGStatusCode, NSData *) = ^void(RPGStatusCode statusCode, NSData *imageData)
  {
    switch (statusCode)
    {
      case kRPGStatusCodeOk:
      {
        self.proofImageView.image = [UIImage imageWithData:imageData];
        break;
      }
      case kRPGStatusCodeWrongToken:
      {
        UIViewController *loginViewController = self.presentingViewController.presentingViewController.presentingViewController;
        [loginViewController dismissViewControllerAnimated:YES completion:nil];
        break;
      }
      default:
      {
        break;
      }
    }
    
  };
  
  NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kRPGNetworkManagerAPIHost, self.proofImageStringURL]];
  [[RPGNetworkManager sharedNetworkManager] getImageProofDataFromURL:imageURL completionHandler:handler];
}

#pragma mark - Send Quest Proof

- (void)sendQuestProofWithResult:(BOOL)aResult
{
  self.acceptButton.enabled = NO;
  self.denyButton.enabled = NO;
  
  __block typeof(self) weakSelf = self;
  
  void (^handler)(NSInteger) = ^void(NSInteger statusCode)
  {
    switch (statusCode)
    {
      case kRPGStatusCodeOk:
      {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
        break;
      }
      case kRPGStatusCodeWrongToken:
      {
        UIViewController *loginViewController = self.presentingViewController.presentingViewController.presentingViewController;
        [loginViewController dismissViewControllerAnimated:YES completion:nil];
        NSString *message = @"Can't send quest proof.\nWrong token error.\nTry to log in again.";
        [RPGAlert showAlertViewControllerWithTitle:@"Error" message:message viewController:loginViewController completion:nil];
        break;
      }
      default:
      {
        NSString *message = @"Can't send quest proof.";
        [RPGAlert showAlertViewControllerWithTitle:@"Error" message:message viewController:weakSelf completion:nil];
        break;
      }
    }
    self.acceptButton.enabled = YES;
    self.denyButton.enabled = YES;
  };
  NSString *token = [[NSUserDefaults standardUserDefaults] sessionToken];
  RPGQuestReviewRequest *request = [RPGQuestReviewRequest questReviewRequestWithToken:token questID:self.questID result:aResult];
  [[RPGNetworkManager sharedNetworkManager] postQuestProofWithRequest:request completionHandler:handler];
}

@end
