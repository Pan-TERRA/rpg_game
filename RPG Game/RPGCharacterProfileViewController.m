  //
  //  RPGCharacterProfileViewController.m
  //  RPG Game
  //
  //  Created by Максим Шульга on 11/16/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGCharacterProfileViewController.h"
  // API
#import "RPGNetworkManager+CharacterProfile.h"
#import "RPGNetworkManager+Skills.h"
  // Controllers
#import "RPGCollectionViewController.h"
#import "RPGWaitingViewController.h"
#import "RPGSkillCollectionViewController.h"
#import "RPGBagCollectionViewController.h"
#import "RPGAvatarCollectionViewController.h"
#import "RPGAlertController+RPGErrorHandling.h"
#import "UIViewController+RPGChildViewController.h"
  // Views
#import "RPGCharacterBagCollectionViewCell.h"
#import "RPGProgressBarView.h"
  // Entities
#import "RPGCharacterRequest.h"
#import "RPGCharacterProfileInfoResponse.h"
#import "RPGCharacterProfileSkill.h"
#import "RPGSkillsResponse.h"
#import "RPGSkillsSelectRequest.h"
#import "RPGCharacterAvatarSelectRequest.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"
  // Constants
#import "RPGNibNames.h"

static NSString * const kRPGCharacterProfileViewControllerWaitingMessageDownload = @"Downloading info";
static NSString * const kRPGCharacterProfileViewControllerWaitingMessageStore = @"Storing skills";
static NSString * const kRPGCharacterProfileViewControllerSkills = @"skills";
static NSString * const kRPGCharacterProfileViewControllerAvatarID = @"avatar_id";

@interface RPGCharacterProfileViewController ()

@property (nonatomic, assign, readwrite) IBOutlet UILabel *nickNameLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *levelLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *expLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *hpLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *attackLabel;
@property (nonatomic, assign, readwrite) IBOutlet RPGProgressBarView *expProgressBar;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *backButton;

@property (nonatomic, assign, readwrite) IBOutlet UICollectionView *skillCollectionView;
@property (nonatomic, assign, readwrite) IBOutlet UICollectionView *bagCollectionView;

@property (nonatomic, retain, readwrite) RPGCollectionViewController *skillCollectionViewController;
@property (nonatomic, retain, readwrite) RPGCollectionViewController *bagCollectionViewController;

@property (nonatomic, retain, readwrite) RPGWaitingViewController *waitingModal;

  //Choose avatar view
@property (nonatomic, retain, readwrite) IBOutlet UIViewController *chooseAvatarView;
@property (nonatomic, assign, readwrite) IBOutlet UICollectionView *chooseAvatarCollectionView;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *chooseAvatarButton;
@property (nonatomic, retain, readwrite) RPGAvatarCollectionViewController *avatarCollectionViewController;

@end

@implementation RPGCharacterProfileViewController

#pragma mark - Init

- (instancetype)init
{
  self = [super initWithNibName:kRPGCharacterProfileViewControllerNIBName bundle:nil];
  
  if (self != nil)
  {
    _skillCollectionViewController = [[RPGSkillCollectionViewController alloc] init];
    _bagCollectionViewController = [[RPGBagCollectionViewController alloc] init];
    _waitingModal = [[RPGWaitingViewController alloc] init];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_skillCollectionViewController release];
  [_bagCollectionViewController release];
  [_waitingModal release];
  [_chooseAvatarView release];
  
  [super dealloc];
}

#pragma mark - Custom Getter

- (NSUInteger)characterLevel
{
  return [self.levelLabel.text integerValue];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UINib *cellNIB = [UINib nibWithNibName:kRPGCharacterBagCollectionViewCellNIBName bundle:nil];
  [self.skillCollectionView registerNib:cellNIB forCellWithReuseIdentifier:kRPGCharacterBagCollectionViewCellNIBName];
  [self.bagCollectionView registerNib:cellNIB forCellWithReuseIdentifier:kRPGCharacterBagCollectionViewCellNIBName];
  
  UINib *avatarCellNIB = [UINib nibWithNibName:kRPGAvatarCollectionViewCellNIBName bundle:nil];
  [self.chooseAvatarCollectionView registerNib:avatarCellNIB forCellWithReuseIdentifier:kRPGAvatarCollectionViewCellNIBName];
  self.avatarCollectionViewController = [[[RPGAvatarCollectionViewController alloc] initWithCollectionView:self.chooseAvatarCollectionView
                                                                                      parentViewController:self
                                                                                       selectedAvatarIndex:[NSUserDefaults standardUserDefaults].characterAvatarID] autorelease];
  self.avatarCollectionViewController.characterClassIndex = [NSUserDefaults standardUserDefaults].characterClassID;
  
  UITapGestureRecognizer *tapGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture)] autorelease];
  tapGesture.numberOfTapsRequired = 1;
  [self.avatarImageView setUserInteractionEnabled:YES];
  [self.avatarImageView addGestureRecognizer:tapGesture];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  [self setViewToWaitingStateWithMessage:kRPGCharacterProfileViewControllerWaitingMessageDownload];
  
  NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
  NSInteger characterID = standardUserDefaults.characterID;
  
  RPGCharacterRequest *request = [RPGCharacterRequest characterRequestWithCharacterID:characterID];
  
  [[RPGNetworkManager sharedNetworkManager] getCharacterProfileInfoWithRequest:request
                                                             completionHandler:^void(RPGStatusCode networkStatusCode,
                                                                                     RPGCharacterProfileInfoResponse *aResponse)
   {
     [self setViewToNormalState];
     
     switch (aResponse.status)
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
         
       case kRPGStatusCodeEmptySkillsToSelect:
       {
         [RPGAlertController showErrorWithStatusCode:kRPGStatusCodeEmptySkillsToSelect completionHandler:nil];
         break;
       }
         
       case kRPGStatusCodeHasNoSuchSkills:
       {
         [RPGAlertController showErrorWithStatusCode:kRPGStatusCodeHasNoSuchSkills completionHandler:nil];
         break;
       }
         
       case kRPGStatusCodeHasNoAnySkills:
       {
         [RPGAlertController showErrorWithStatusCode:kRPGStatusCodeHasNoAnySkills completionHandler:nil];
         break;
       }
         
       case kRPGStatusCodeExceedActiveSkillsBagSize:
       {
         [RPGAlertController showErrorWithStatusCode:kRPGStatusCodeExceedActiveSkillsBagSize completionHandler:nil];
         break;
       }
         
       default:
       {
         [self handleDefaultError];
         break;
       }
     }
   }];
  
  NSInteger characterClassID = standardUserDefaults.characterClassID;
  NSInteger characterAvatarID = standardUserDefaults.characterAvatarID - 1;
  
  self.avatarImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"avatar_%ld_%ld", (long)characterClassID, (long)characterAvatarID]];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  return UIInterfaceOrientationMaskLandscape;
}

#pragma mark - Show ChooseAvatarView

- (void)handleTapGesture
{
  [self addChildViewController:self.chooseAvatarView frame:self.view.frame];
//  RPGQuestProofImageViewController *questProofImageViewController = [[RPGQuestProofImageViewController alloc] init];
//  [self.questViewController presentViewController:questProofImageViewController animated:YES completion:nil];
//  [questProofImageViewController setImage:self.proofImageView.image];
//  [questProofImageViewController release];
}

#pragma mark - Error Handling

- (void)handleWrongTokenError
{
  [RPGAlertController showErrorWithStatusCode:kRPGStatusCodeWrongToken completionHandler:^
   {
     dispatch_async(dispatch_get_main_queue(), ^
     {
       UIViewController *viewController = self.presentingViewController.presentingViewController;
       [viewController dismissViewControllerAnimated:YES completion:nil];
     });
   }];
}

- (void)handleDefaultError
{
  [RPGAlertController showErrorWithStatusCode:kRPGStatusCodeDefaultError completionHandler:^
   {
     dispatch_async(dispatch_get_main_queue(), ^
     {
       [self dismissViewControllerAnimated:YES completion:nil];
     });
   }];
}

#pragma mark - Update View

- (void)updateViewWithResponse:(RPGCharacterProfileInfoResponse *)aResponse
{
  self.nickNameLabel.text = [NSUserDefaults standardUserDefaults].characterNickName;
  self.levelLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)aResponse.currentLevel];
  self.expLabel.text = [NSString stringWithFormat:@"%lu/%lu", (unsigned long)aResponse.currentExp, (unsigned long)aResponse.maxExp];
  self.hpLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)aResponse.HP];
  self.attackLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)aResponse.attack];
  self.expProgressBar.progress = (CGFloat)aResponse.currentExp / aResponse.maxExp;
  
  NSMutableArray *skillCollectionArray = [NSMutableArray array];
  NSMutableArray *bagCollectionArray = [NSMutableArray array];
  
  for (RPGCharacterProfileSkill *skill in aResponse.skills)
  {
    if (skill.isSelected)
    {
      [skillCollectionArray addObject:@(skill.skillID)];
    }
    else
    {
      [bagCollectionArray addObject:@(skill.skillID)];
    }
  }
  
  self.skillCollectionViewController = [[[RPGSkillCollectionViewController alloc] initWithCollectionView:self.skillCollectionView
                                                                                    parentViewController:self
                                                                                          collectionSize:aResponse.activeSkillsBagSize
                                                                                             skillsArray:skillCollectionArray] autorelease];
  self.bagCollectionViewController = [[[RPGBagCollectionViewController alloc] initWithCollectionView:self.bagCollectionView
                                                                                parentViewController:self
                                                                                      collectionSize:aResponse.bagSize
                                                                                         skillsArray:bagCollectionArray] autorelease];
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

- (void)setBackButtonState
{
  self.backButton.enabled = (self.skillCollectionViewController.skillsIDArray.count != 0);
}

#pragma mark - Actions

- (IBAction)chooseAvatarButtonOnClick:(UIButton *)sender
{
  NSInteger index = self.avatarCollectionViewController.selectedAvatarIndex + 1;
  RPGCharacterAvatarSelectRequest *request = [RPGCharacterAvatarSelectRequest characterAvatarSelectRequestWithAvatarID:index];
  [[RPGNetworkManager sharedNetworkManager] characterAvatarSelectWithRequest:request
                                                           completionHandler:^(RPGStatusCode networkStatusCode)
  {
    switch (networkStatusCode)
    {
      case kRPGStatusCodeOK:
      {
        [self saveSelectedAvatarID];
        
        //[self saveSelectedSkills];
        //[self dismissViewControllerAnimated:YES completion:nil];
        break;
      }
       
      case kRPGStatusCodeWrongToken:
      {
        [self handleWrongTokenError];
      }
       
      default:
      {
        [self handleDefaultError];
        break;
      }
   }
    
  }];
  [self.chooseAvatarView.view removeFromSuperview];
  [self.chooseAvatarView removeFromParentViewController];
}

- (IBAction)back:(UIButton *)sender
{
  [self setViewToWaitingStateWithMessage:kRPGCharacterProfileViewControllerWaitingMessageStore];
  
  NSUInteger characterID = [NSUserDefaults standardUserDefaults].characterID;
  NSArray *skills = self.skillCollectionViewController.skillsIDArray;
  
  RPGSkillsSelectRequest *request = [RPGSkillsSelectRequest skillSelectRequestWithCharacterID:characterID skills:skills];
  [[RPGNetworkManager sharedNetworkManager] selectSkillsWithRequest:request
                                                  completionHandler:^void(RPGStatusCode networkStatusCode)
   {
     [self setViewToNormalState];
     
     switch (networkStatusCode)
     {
       case kRPGStatusCodeOK:
       {
         [self saveSelectedSkills];
         [self dismissViewControllerAnimated:YES completion:nil];
         break;
       }
         
       case kRPGStatusCodeWrongToken:
       {
         [self handleWrongTokenError];
       }
         
       default:
       {
         [self handleDefaultError];
         break;
       }
     }
   }];
}

#pragma mark - Save To UserDefaults

- (void)saveSelectedSkills
{
  NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
  NSMutableArray *characters = [[standardUserDefaults.sessionCharacters mutableCopy] autorelease];
  NSMutableDictionary *character = [[[characters firstObject] mutableCopy] autorelease];
  
  character[kRPGCharacterProfileViewControllerSkills] = self.skillCollectionViewController.skillsIDArray;
  characters[0] = character;
  
  standardUserDefaults.sessionCharacters = characters;
}

- (void)saveSelectedAvatarID
{
  NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
  NSMutableArray *characters = [[standardUserDefaults.sessionCharacters mutableCopy] autorelease];
  NSMutableDictionary *character = [[[characters firstObject] mutableCopy] autorelease];
  
  character[kRPGCharacterProfileViewControllerAvatarID] = @(self.avatarCollectionViewController.selectedAvatarIndex + 1);
  characters[0] = character;
  
  standardUserDefaults.sessionCharacters = characters;
  
  self.avatarImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"avatar_%ld_%ld", (long)standardUserDefaults.characterClassID, (long)standardUserDefaults.characterAvatarID]];
}

#pragma mark - Add To Collection

- (void)addSkillToSkillCollectionWithID:(NSUInteger)anItemID type:(RPGItemType)aType;
{
  [self.skillCollectionViewController addItem:anItemID type:aType];
  [self setBackButtonState];
}

- (void)addItemToBagCollectionWithID:(NSUInteger)aSkillID type:(RPGItemType)aType;
{
  [self.bagCollectionViewController addItem:aSkillID type:aType];
  [self setBackButtonState];
}

@end
