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
#import "RPGWaitingViewController.h"
#import "UIViewController+RPGChildViewController.h"
  // Entities
#import "RPGQuest.h"
#import "RPGQuestReward.h"
#import "RPGQuestRequest.h"
#import "RPGQuestReviewRequest.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"
#import "RPGAlertController.h"
  // Constants
#import "RPGNibNames.h"
#import "RPGQuestAction.h"

NSString * const kRPGQuestViewControllerWaitingMessageDownload = @"Downloading image";
NSString * const kRPGQuestViewControllerWaitingMessageUpload = @"Uploading image";

@interface RPGQuestViewController () 

@property (nonatomic, assign, readwrite) NSInteger questID;
@property (nonatomic, assign, readwrite, getter=hasGotReward) BOOL getReward;

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

- (void)viewWillAppear:(BOOL)anAnimated
{
  [super viewWillAppear:anAnimated];
  
  if (![self.proofImageStringURL isKindOfClass:[NSNull class]] && self.proofImageStringURL != nil)
  {
    [self.bodyContainer downloadImage];
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
    self.questID = aQuest.questID;
    self.getReward = aQuest.hasGotReward;
    self.proofImageStringURL = aQuest.proofImageStringURL;
    self.state = aQuest.state;
    
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
