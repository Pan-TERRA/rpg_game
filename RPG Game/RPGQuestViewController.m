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
#import "RPGWaitingViewController.h"
#import "UIViewController+RPGChildViewController.h"
  // Controllers
#import "RPGHeaderQuestViewController.h"
#import "RPGBodyQuestViewController.h"
#import "RPGButtonQuestViewController.h"
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

@property (nonatomic, assign, readwrite) RPGHeaderQuestViewController *headerContainerController;
@property (nonatomic, retain, readwrite) IBOutlet UIView *headerContainer;

@property (nonatomic, assign, readwrite) RPGBodyQuestViewController *bodyContainerController;
@property (nonatomic, retain, readwrite) IBOutlet UIView *bodyContainer;

@property (nonatomic, assign, readwrite) RPGButtonQuestViewController *buttonContainerController;
@property (nonatomic, retain, readwrite) IBOutlet UIView *buttonContainer;

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
    
    _headerContainerController = [[RPGHeaderQuestViewController alloc] initWithQuestViewController:self];
    _bodyContainerController = [[RPGBodyQuestViewController alloc] initWithQuestViewController:self];
    _buttonContainerController = [[RPGButtonQuestViewController alloc] initWithQuestViewController:self];
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
  
  [self addChildViewController:self.headerContainerController
                          view:self.headerContainer];
  [self addChildViewController:self.bodyContainerController
                          view:self.bodyContainer];
  [self addChildViewController:self.buttonContainerController
                          view:self.buttonContainer];
}

- (void)viewWillAppear:(BOOL)anAnimated
{
  [super viewWillAppear:anAnimated];
  
  NSString *proofImageStringURL1 = self.proofImageStringURL1;
  NSString *proofImageStringURL2 = self.proofImageStringURL2;
  RPGBodyQuestViewController *bodyContainerController = self.bodyContainerController;
  
  if (![proofImageStringURL1 isEqualToString:kRPGQuestViewControllerEmptyString])
  {
    [self.bodyContainerController downloadImage:proofImageStringURL1
                                      imageView:bodyContainerController.proofImageView1];
  }
  if (![proofImageStringURL2 isEqualToString:kRPGQuestViewControllerEmptyString])
  {
    [self.bodyContainerController downloadImage:proofImageStringURL2
                                      imageView:bodyContainerController.proofImageView2];
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
    self.questType = aQuest.questType;
    self.questID = aQuest.questID;
    self.getReward = aQuest.hasGotReward;
    self.proofImageStringURL1 = aQuest.proofImageStringURL1;
    if (![self.proofImageStringURL1 isEqualToString:kRPGQuestViewControllerEmptyString])
    {
      self.makeProof = YES;
    }
    self.state = aQuest.state;
    
    [self.headerContainerController setViewContent:aQuest.reward];
    [self.bodyContainerController setViewContent:aQuest];
    
    if (self.questType == kRPGQuestTypeDuel)
    {
      RPGDuelQuest *duelQuest = (RPGDuelQuest *)aQuest;
      self.duelQuestFriendID = duelQuest.friendID;
      self.proofImageStringURL2 = duelQuest.proofImageStringURL2;
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
    picker.delegate = self.bodyContainerController;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    _imagePickerController = [picker retain];
  }
  
  return _imagePickerController;
}

#pragma mark - Custom Setter

- (void)setState:(RPGQuestState)aState
{
  _state = aState;
  
  [self.headerContainerController updateView];
  [self.bodyContainerController updateView];
  [self.buttonContainerController updateView];
}
- (IBAction)handleTapGesture:(UITapGestureRecognizer *)aSender
{
  RPGBodyQuestViewController *bodyContainerController = self.bodyContainerController;
  CGPoint point = [aSender locationInView:self.bodyContainer];
  UIImageView *proofImageView1 = bodyContainerController.proofImageView1;
  UIImageView *proofImageView2 = bodyContainerController.proofImageView2;
  UIImageView *imageView = nil;
  
  if (proofImageView1.hidden == NO
      && CGRectContainsPoint(proofImageView1.frame, point))
  {
    imageView = proofImageView1;
  }
  else if (proofImageView2.hidden == NO
           && CGRectContainsPoint(proofImageView2.frame, point))
  {
    imageView = proofImageView2;
  }
  
  if (imageView != nil)
  {
    RPGQuestProofImageViewController *questProofImageViewController = [[[RPGQuestProofImageViewController alloc] init] autorelease];
    
    [self presentViewController:questProofImageViewController
                       animated:YES
                     completion:nil];
    
    questProofImageViewController.proofImage = imageView.image;
  }
}

@end
