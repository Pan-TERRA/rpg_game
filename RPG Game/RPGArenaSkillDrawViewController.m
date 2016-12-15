//
//  RPGArenaSkillDrawViewController.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/20/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGArenaSkillDrawViewController.h"
  // API
#import "RPGArenaFactory.h"
#import "RPGNetworkManager+Arena.h"
  // Controllers
#import "RPGWaitingViewController.h"
#import "RPGArenaSkillCollectionViewController.h"
#import "RPGArenaBagCollectionViewController.h"
#import "UIViewController+RPGChildViewController.h"
#import "RPGBattleViewController.h"
#import "RPGAlertController+RPGErrorHandling.h"
  // Views
#import "RPGCharacterBagCollectionViewCell.h"
  // Entities
#import "RPGArenaSkillsResponse.h"
#import "RPGArenaController.h"
#import "RPGArenaBag.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"
#import "UIViewController+RPGWrongTokenHandling.h"
  // Constants
#import "RPGNibNames.h"
#import "RPGItemTypes.h"

static NSString * const kRPGArenaSkillDrawViewControllerWaitingMessageFetching = @"Fetching skills";

@interface RPGArenaSkillDrawViewController () <RPGArenaCollectionViewControllerDelegate>

@property (nonatomic, retain, readwrite) RPGArenaBagCollectionViewController *bagSetCollectionViewController;
@property (nonatomic, retain, readwrite) RPGArenaSkillCollectionViewController *skillsCollectionViewController;

@property (nonatomic, assign, readwrite) IBOutlet UICollectionView *bagSetCollectionView;
@property (nonatomic, assign, readwrite) IBOutlet UICollectionView *skillsCollectionView;

@property (nonatomic, assign, readwrite) IBOutlet UIButton *startBattleButton;

@property (nonatomic, retain, readwrite) RPGWaitingViewController *waitingModal;

@property (nonatomic, retain, readwrite) RPGArenaBag *bag;
@property (nonatomic, retain, readwrite) RPGArenaController *arenaController;

@end

@implementation RPGArenaSkillDrawViewController

#pragma mark - Init

- (instancetype)init
{
  self = [super initWithNibName:kRPGArenaSkillDrawViewControllerNIBName
                         bundle:nil];
  
  if (self != nil)
  {
    _bagSetCollectionViewController = [[RPGArenaBagCollectionViewController alloc] init];
    _skillsCollectionViewController = [[RPGArenaSkillCollectionViewController alloc] init];
    _waitingModal = [[RPGWaitingViewController alloc] initWithMessage:kRPGArenaSkillDrawViewControllerWaitingMessageFetching
                                                           completion:nil];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_bagSetCollectionViewController release];
  [_skillsCollectionViewController release];
  [_waitingModal release];
  [_bag release];
  [_arenaController release];
  
  [super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UINib *cellNIB = [UINib nibWithNibName:kRPGCharacterBagCollectionViewCellNIBName
                                  bundle:nil];
  [self.skillsCollectionView registerNib:cellNIB
              forCellWithReuseIdentifier:kRPGCharacterBagCollectionViewCellNIBName];
  [self.bagSetCollectionView registerNib:cellNIB
              forCellWithReuseIdentifier:kRPGCharacterBagCollectionViewCellNIBName];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  [self setViewToWaitingStateWithMessage:kRPGArenaSkillDrawViewControllerWaitingMessageFetching];
  
  [[RPGNetworkManager sharedNetworkManager] fetchSkillsWithCompletionHandler:^(RPGStatusCode aNetworkStatusCode,
                                                                               RPGArenaSkillsResponse *aResponse)
  {
    [self setViewToNormalState];
    
    switch (aNetworkStatusCode)
    {
      case kRPGStatusCodeOK:
      {
        [self updateViewWithResponse:aResponse];
        break;
      }
      
      case kRPGStatusCodeWrongToken:
      {
        [self handleWrongTokenError];
        break;
      }
      
      default:
      {
        [self handleDefaultError];
        break;
      }
    }
  }];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  return UIInterfaceOrientationMaskLandscape;
}

- (UIViewController *)getViewController
{
  return self;
}

#pragma mark - Update View

- (void)updateViewWithResponse:(RPGArenaSkillsResponse *)aResponse
{
  NSArray *skillIDs = aResponse.skills;
  NSUInteger skillCollectionSize = skillIDs.count / kRPGArenaBagSetSize;
  
  self.skillsCollectionViewController = [[[RPGArenaSkillCollectionViewController alloc]
                                          initWithCollectionView:self.skillsCollectionView
                                          collectionSize:skillCollectionSize
                                          skillsArray:[NSArray array]] autorelease];
  self.skillsCollectionViewController.delegate = self;
  
  self.bag = [[[RPGArenaBag alloc] initWithArray:skillIDs] autorelease];
  
  [self reloadBagSetCollection];
}

#pragma mark - Error Handling

- (void)handleDefaultError
{
  [RPGAlertController showErrorWithStatusCode:kRPGStatusCodeDefaultError
                            completionHandler:^
  {
    dispatch_async(dispatch_get_main_queue(), ^
    {
      [self dismissViewControllerAnimated:YES
                               completion:nil];
    });
  }];
}

#pragma mark - View State

- (void)setViewToWaitingStateWithMessage:(NSString *)aMessage
{
  self.waitingModal.message = aMessage;
  [self addChildViewController:self.waitingModal frame:self.view.frame];
}

- (void)setViewToNormalState
{
  [self.waitingModal.view removeFromSuperview];
  [self.waitingModal removeFromParentViewController];
}

#pragma mark - Add To Collection

- (void)addSkillToSkillCollectionWithID:(NSUInteger)aSkillID;
{
  [self.skillsCollectionViewController addItem:aSkillID
                                          type:kRPGItemTypeSkill];
  [self reloadBagSetCollection];
}

- (void)reloadBagSetCollection
{
  NSArray *nextItems = [self.bag getNextRandomItems];
  if (nextItems != nil)
  {
    self.bagSetCollectionViewController = [[[RPGArenaBagCollectionViewController alloc]
                                            initWithCollectionView:self.bagSetCollectionView
                                            collectionSize:kRPGArenaBagSetSize
                                            skillsArray:nextItems] autorelease];
    self.bagSetCollectionViewController.delegate = self;
  }
  else
  {
    [self completeSkillSelection];
  }
}

- (void)completeSkillSelection
{
  self.bagSetCollectionView.hidden = YES;
  self.startBattleButton.enabled = YES;
}

#pragma mark - Actions

- (IBAction)handleStartBattleButton
{
  [self saveSelectedSkills];

  RPGArenaFactory *arenaFactory = [[[RPGArenaFactory alloc] init] autorelease];
  RPGBattleViewController *viewController = [[[RPGBattleViewController alloc]
                                              initWithBattleFactory:arenaFactory]
                                             autorelease];
  
  [self.delegate dismissCurrentAndPresentViewController:viewController];
}

- (IBAction)back:(UIButton *)aSender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveSelectedSkills
{
  NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
  standardUserDefaults.selectedArenaSkills = self.skillsCollectionViewController.skillsIDArray;
}

@end
