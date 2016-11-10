//
//  RPGQuestViewController.m
//  RPG Game
//
//  Created by Максим Шульга on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//


#import "RPGQuestViewController.h"
  // API
#import "RPGNetworkManager+Quests.h"
  // Views
#import "RPGQuestListViewController.h"
#import "RPGQuestProofImageViewController.h"
  // Entities
#import "RPGQuest.h"
#import "RPGQuestReward.h"
#import "RPGQuestRequest.h"
#import "RPGQuestReviewRequest.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"
#import "RPGAlert.h"
  // Constants
#import "RPGNibNames.h"
#import "RPGQuestAction.h"


#import "RPGQuestViewHeaderContainer.h"
#import "RPGQuestViewBodyContainer.h"
#import "RPGQuestViewButtonContainer.h"

@interface RPGQuestViewController () 




@property (nonatomic, assign, readwrite) NSUInteger questID;

@property (nonatomic, copy, readwrite) NSString *proofImageStringURL;
@property (nonatomic, retain, readwrite) UIImagePickerController *imagePickerController;

@property (nonatomic, assign, readwrite) IBOutlet RPGQuestViewHeaderContainer *headerContainer;
@property (nonatomic, assign, readwrite) IBOutlet RPGQuestViewBodyContainer *bodyContainer;
@property (nonatomic, assign, readwrite) IBOutlet RPGQuestViewButtonContainer *buttonContainer;

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

- (UIImagePickerController *)imagePickerController
{
  if (_imagePickerController == nil)
  {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self.bodyContainer;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    _imagePickerController = [picker retain];
  }
  return _imagePickerController;
}

#pragma mark - Custom Setter

- (void)setState:(RPGQuestState)aState
{
  _state = aState;
  
  [self.headerContainer updateView];
  [self.bodyContainer updateView];
  [self.buttonContainer updateView];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
//  UITapGestureRecognizer *tapGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture)] autorelease];
//  tapGesture.numberOfTapsRequired = 1;
//  [self.proofImageView setUserInteractionEnabled:YES];
//  [self.proofImageView addGestureRecognizer:tapGesture];
  
  self.buttonContainer.questViewController = self;
  self.headerContainer.questViewController = self;
  self.bodyContainer.questViewController = self;
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
        [self.bodyContainer uploadImage];
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
  return UIInterfaceOrientationMaskLandscape;
}

#pragma mark - View Content

- (void)setViewContent:(RPGQuest *)aQuest
{
  RPGQuestState state = aQuest.state;
  self.state = state;
  self.questID = aQuest.questID;
  self.proofImageStringURL = aQuest.proofImageStringURL;
  
  [self.headerContainer setViewContent:aQuest.reward];
  [self.bodyContainer setViewContent:aQuest];
}

@end
