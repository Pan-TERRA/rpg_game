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
#import "RPGDuelQuest.h"
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
static NSString * const kRPGQuestViewControllerEmptyString = @"";

@interface RPGQuestViewController () 

@property (nonatomic, assign, readwrite) RPGQuestType questType;
@property (nonatomic, assign, readwrite) NSInteger questID;
@property (nonatomic, assign, readwrite) NSInteger duelQuestFriendID;
@property (nonatomic, assign, readwrite, getter=hasGotReward) BOOL getReward;

@property (nonatomic, copy, readwrite) NSString *proofImageStringURL1;
@property (nonatomic, copy, readwrite) NSString *proofImageStringURL2;
@property (nonatomic, retain, readwrite) UIImagePickerController *imagePickerController;

@property (nonatomic, assign, readwrite) IBOutlet RPGQuestViewHeaderContainer *headerContainer;
@property (nonatomic, assign, readwrite) IBOutlet RPGQuestViewBodyContainer *bodyContainer;
@property (nonatomic, assign, readwrite) IBOutlet RPGQuestViewButtonContainer *buttonContainer;

@end

@implementation RPGQuestViewController

#pragma mark - Init

- (instancetype)init
{
  self = [super initWithNibName:kRPGQuestViewControllerNIBName
                         bundle:nil];
  
  if (self != nil)
  {
    _proofImageStringURL1 = kRPGQuestViewControllerEmptyString;
    _proofImageStringURL2 = kRPGQuestViewControllerEmptyString;
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_imagePickerController release];
  [_proofImageStringURL1 release];
  [_proofImageStringURL2 release];

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
  
  NSString *proofImageStringURL1 = self.proofImageStringURL1;
  NSString *proofImageStringURL2 = self.proofImageStringURL2;
  RPGQuestViewBodyContainer *bodyContainer = self.bodyContainer;
  
  if (![proofImageStringURL1 isEqualToString:kRPGQuestViewControllerEmptyString])
  {
    [self.bodyContainer downloadImage:proofImageStringURL1
                            imageView:bodyContainer.proofImageView1];
  }
  if (![proofImageStringURL2 isEqualToString:kRPGQuestViewControllerEmptyString])
  {
    [self.bodyContainer downloadImage:proofImageStringURL2
                            imageView:bodyContainer.proofImageView2];
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
    self.proofImageStringURL1 = aQuest.proofImageStringURL1;
    if (![self.proofImageStringURL1 isEqualToString:kRPGQuestViewControllerEmptyString])
    {
      self.makeProof = YES;
    }
    self.state = aQuest.state;
    self.questType = aQuest.questType;
    
    [self.headerContainer setViewContent:aQuest.reward];
    [self.bodyContainer setViewContent:aQuest];
    
    if (self.questType == kRPGQuestTypeDuel)
    {
      self.duelQuestFriendID = ((RPGDuelQuest *)aQuest).friendID;
      self.proofImageStringURL2 = ((RPGDuelQuest *)aQuest).proofImageStringURL2;
    }
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
