//
//  RPGQuestViewController.m
//  RPG Game
//
//  Created by Максим Шульга on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestViewController.h"
#import "RPGQuestListViewController.h"
#import "RPGQuestProofImageViewController.h"
#import "RPGNibNames.h"
#import "RPGQuest+Serialization.h"
#import "RPGQuestReward+Serialization.h"
#import "RPGNetworkManager+Quests.h"
#import "RPGQuestRequest+Serialization.h"
#import "RPGQuestReviewRequest+Serialization.h"
#import "NSUserDefaults+RPGSessionInfo.h"
#import "RPGQuestAction.h"

@interface RPGQuestViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, assign, readwrite) IBOutlet UIButton *acceptButton;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *denyButton;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *addProofButton;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *proofLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *proofImageView;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *rewardLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *rewardTypeImageView;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *proofTypeImageView;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *stateTitleLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *stateLabel;
@property (nonatomic, assign, readwrite) RPGQuestState state;
@property (nonatomic, assign, readwrite) NSUInteger questID;
@property (nonatomic, copy, readwrite) NSString *proofImageStringURL;
@property (nonatomic, retain, readwrite) UIImagePickerController *imagePickerController;

@end

@implementation RPGQuestViewController

#pragma mark - Init

- (instancetype)init
{
  return [super initWithNibName:kRPGQuestViewController
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
    UIImagePickerController *picker = [[[UIImagePickerController alloc] init] autorelease];
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
  [super viewWillAppear:animated];
  switch (self.state)
  {
    case kRPGQuestStateDone:
    case kRPGQuestStateReviewedFalse:
    case kRPGQuestStateForReview:
    case kRPGQuestStateReviewedTrue:
    {
      void (^handler)(NSData *) = ^void(NSData *imageData)
      {
        self.proofImageView.image = [[[UIImage alloc] initWithData:imageData] autorelease];
      };
      NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", @"http://10.55.33.31:8000", self.proofImageStringURL]];
      [[RPGNetworkManager sharedNetworkManager] getImageProofDataFromURL:imageURL completionHandler:handler];
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
  self.rewardLabel.text = [@(aQuest.reward.gold) stringValue];
  self.state = aQuest.state;
  self.questID = aQuest.questID;
  self.proofImageStringURL = aQuest.proofImageStringURL;
  
  switch (self.state)
  {
    case kRPGQuestStateCanTake:
    {
      [self setStateTakeQuest];
      break;
    }
    case kRPGQuestStateInProgress:
    {
      [self setStateInProgressQuest];
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

- (void)setStateTakeQuest
{
  self.acceptButton.hidden = NO;
  self.denyButton.hidden = YES;
  self.addProofButton.hidden = NO;
  [self setProofItemsHidden:YES];
  [self setStateItemsHidden:YES];
}

- (void)setStateInProgressQuest
{
  self.acceptButton.hidden = YES;
  self.denyButton.hidden = YES;
  self.addProofButton.hidden = NO;
  [self setProofItemsHidden:YES];
  [self setStateItemsHidden:NO];
}

- (void)setStateReviewedQuest:(BOOL)aFlag
{
  self.acceptButton.hidden = YES;
  self.denyButton.hidden = YES;
  self.addProofButton.hidden = YES;
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
    void (^handler)(NSInteger) = ^void(NSInteger status)
    {
      BOOL success = (status == 0);
      if (success)
      {
        
      }
    };
    RPGQuestRequest *request = [[[RPGQuestRequest alloc] initWithToken:[[NSUserDefaults standardUserDefaults] sessionToken] questID:self.questID] autorelease];
    [[RPGNetworkManager sharedNetworkManager] doQuestAction:kRPGQuestActionTakeQuest request:request completionHandler:handler];
  }
  else if (self.state == kRPGQuestStateForReview)
  {
    [self sendQuestProofWithResult:YES];
  }
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)denyButtonOnClick:(UIButton *)aSender
{
  [self sendQuestProofWithResult:NO];
}

- (IBAction)addProofButtonOnClick:(UIButton *)aSender
{
  if (self.pickerController)
  {
    [self presentViewController:self.pickerController animated:NO completion:nil];
  }
}

- (IBAction)backButtonOnClick:(UIButton *)aSender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

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
  self.proofImageView.image = chosenImage;
  
  self.state = kRPGQuestStateDone;
  [self setStateReviewedQuest:NO];
  self.stateLabel.text = kRPGQuestStringStateNotReviewed;
  
  //send image to server
  void (^handler)(NSInteger) = ^void(NSInteger status)
  {
    BOOL success = (status == 0);
    if (success)
    {
      
    }
  };
  
  NSData *data = UIImagePNGRepresentation(chosenImage);
  RPGQuestRequest *request = [[[RPGQuestRequest alloc] initWithToken:[[NSUserDefaults standardUserDefaults] sessionToken] questID:self.questID] autorelease];
  [[RPGNetworkManager sharedNetworkManager] addProofWithRequest:request imageData:data completionHandler:handler];
  
  [aPicker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)aPicker
{
  [aPicker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Send Quest Proof

- (void)sendQuestProofWithResult:(BOOL)aResult
{
  void (^handler)(NSInteger) = ^void(NSInteger status)
  {
    BOOL success = (status == 0);
    if (success)
    {
      
    }
  };
  RPGQuestReviewRequest *request = [[RPGQuestReviewRequest alloc] initWithToken:[[NSUserDefaults standardUserDefaults] sessionToken] questID:self.questID result:aResult];
  [[RPGNetworkManager sharedNetworkManager] postQuestProofWithRequest:request completionHandler:handler];
}

@end
