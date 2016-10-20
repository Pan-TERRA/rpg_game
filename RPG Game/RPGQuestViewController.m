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

@end

@implementation RPGQuestViewController

#pragma mark - Init

- (instancetype)init
{
  return [super initWithNibName:kRPGQuestViewController
                         bundle:nil];
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

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

#pragma mark - Set view state and content

- (void)setViewContent:(NSDictionary *)aViewContent
{
  self.titleLabel.text = [aViewContent objectForKey:kRPGQuestTitle];
  self.descriptionLabel.text = [aViewContent objectForKey:kRPGQuestDescription];
  self.rewardLabel.text = [aViewContent objectForKey:kRPGQuestReward];
  self.state = [[aViewContent objectForKey:kRPGQuestState] integerValue];
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
  
  switch (self.state)
  {
    case kRPGQuestStateDone:
    case kRPGQuestStateReviewedFalse:
    case kRPGQuestStateForReview:
    case kRPGQuestStateReviewedTrue:
    {
      //upload image from server
      //self.proofImageView.image = ...
      break;
    }
    default:
    {
      break;
    }
  }
}

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

#pragma mark - Event Handling

- (IBAction)acceptButtonOnClick:(UIButton *)aSender
{
  if (self.state == kRPGQuestStateCanTake)
  {
    //send to server that quest should be in progress
  }
  else if (self.state == kRPGQuestStateForReview)
  {
    //send to server that quest was done
  }
}

- (IBAction)denyButtonOnClick:(UIButton *)aSender
{
  //send to server that quest wasn't done
}

- (IBAction)addProofButtonOnClick:(UIButton *)aSender
{
  UIImagePickerController *picker = [[[UIImagePickerController alloc] init] autorelease];
  picker.delegate = self;
  picker.allowsEditing = YES;
  picker.sourceType = UIImagePickerControllerSourceTypeCamera;
  [self presentViewController:picker animated:YES completion:nil];
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
  [aPicker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)aPicker
{
  [aPicker dismissViewControllerAnimated:YES completion:NULL];
}

@end
