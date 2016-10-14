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
#import "NibNames.h"

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

#pragma mark - UIViewController Methods

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

#pragma mark - set view state and content

- (void)setViewContent:(NSDictionary *)viewContent
{
  self.titleLabel.text = [viewContent objectForKey:kRPGQuestTitle];
  self.descriptionLabel.text = [viewContent objectForKey:kRPGQuestDescription];
  self.rewardLabel.text = [viewContent objectForKey:kRPGQuestReward];
  RPGQuestState state = [[viewContent objectForKey:kRPGQuestState] integerValue];
  switch (state)
  {
    case kRPGQuestStateCanTake:
      [self setStateTakeQuest];
      break;
    case kRPGQuestStateInProgress:
      [self setStateInProgressQuest];
      self.stateLabel.text = kRPGQuestStringStateInProgress;
      break;
    case kRPGQuestStateDone:
      [self setStateReviewedQuest:NO];
      self.stateLabel.text = kRPGQuestStringStateNotReviewed;
      break;
    case kRPGQuestStateReviewedFalse:
      [self setStateReviewedQuest:NO];
      self.stateLabel.text = kRPGQuestStringStateReviewedFalse;
      break;
    case kRPGQuestStateForReview:
      [self setStateForReviewQuest];
      break;
    case kRPGQuestStateReviewedTrue:
      [self setStateReviewedQuest:YES];
      break;
    default:
      break;
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

- (void)setStateReviewedQuest:(BOOL)flag
{
  self.acceptButton.hidden = YES;
  self.denyButton.hidden = YES;
  self.addProofButton.hidden = YES;
  [self setProofItemsHidden:NO];
  [self setStateItemsHidden:flag];
}

- (void)setStateForReviewQuest
{
  self.acceptButton.hidden = NO;
  self.denyButton.hidden = NO;
  self.addProofButton.hidden = YES;
  [self setProofItemsHidden:NO];
  [self setStateItemsHidden:YES];
}

- (void)setProofItemsHidden:(BOOL)flag
{
  self.proofLabel.hidden = flag;
  self.proofImageView.hidden = flag;
}

- (void)setStateItemsHidden:(BOOL)flag
{
  self.stateTitleLabel.hidden = flag;
  self.stateLabel.hidden = flag;
}

#pragma mark - Event Handling

- (IBAction)acceptButtonOnClick:(UIButton *)sender
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

- (IBAction)denyButtonOnClick:(UIButton *)sender
{
  //send to server that quest wasn't done
}

- (IBAction)addProofButtonOnClick:(UIButton *)sender
{
  UIImagePickerController *picker = [[[UIImagePickerController alloc] init] autorelease];
  picker.delegate = self;
  picker.allowsEditing = YES;
  picker.sourceType = UIImagePickerControllerSourceTypeCamera;
  [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)backButtonOnClick:(UIButton *)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)handleTapGesture
{
  RPGQuestProofImageViewController *questProofImageViewController = [[[RPGQuestProofImageViewController alloc] initWithNibName:kRPGQuestProofImageViewController bundle:nil] autorelease];
  [self presentViewController:questProofImageViewController animated:YES completion:nil];
  [questProofImageViewController setImage:self.proofImageView.image];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
  UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
  self.proofImageView.image = chosenImage;
  [self setStateReviewedQuest:NO];
  self.stateLabel.text = kRPGQuestStringStateNotReviewed;
  //send image to server
  [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
  [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end