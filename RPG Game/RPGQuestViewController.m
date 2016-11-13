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
#import "RPGQuestViewHeaderContainer.h"
#import "RPGQuestViewBodyContainer.h"
#import "RPGQuestViewButtonContainer.h"
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

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.buttonContainer.questViewController = self;
  self.headerContainer.questViewController = self;
  self.bodyContainer.questViewController = self;
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  
    //  switch (self.state)
//  {
//    case kRPGQuestStateInProgress:
//    case kRPGQuestStateForReview:
//    case kRPGQuestStateDone:
//    case kRPGQuestStateReviewedFalse:
//    case kRPGQuestStateReviewedTrue:
//    {
//      if (self.proofImageStringURL != nil)
//      {
//        [self.bodyContainer uploadImage];
//      }
//      break;
//    }
//      
//    default:
//    {
//      break;
//    }x
//  }
  
  if (self.state != kRPGQuestStateCanTake && self.proofImageStringURL != nil)
  {
    [self.bodyContainer uploadImage];
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
  if (aQuest != nil)
  {
      //  RPGQuestState state = aQuest.state;
    self.state = aQuest.state;
    self.questID = aQuest.questID;
    self.proofImageStringURL = aQuest.proofImageStringURL;
    
    [self.headerContainer setViewContent:aQuest.reward];
    [self.bodyContainer setViewContent:aQuest];
  }
}

#pragma mark - Image Picker Controller

  // custom getter
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

@end
