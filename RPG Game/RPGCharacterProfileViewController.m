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
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"
  // Constants
#import "RPGNibNames.h"

static NSString * const kRPGCharacterProfileViewControllerWaitingMessageDownload = @"Downloading info";
static NSString * const kRPGCharacterProfileViewControllerWaitingMessageStore = @"Storing skills";
static NSString * const kRPGCharacterProfileViewControllerSkills = @"skills";

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
  
  [[RPGNetworkManager sharedNetworkManager] getImageDataFromPath:standardUserDefaults.sessionAvatar
                                               completionHandler:^(NSInteger aStatusCode, NSData * anImageData)
  {
    switch (aStatusCode)
    {
      case kRPGStatusCodeOK:
      {
        self.avatarImageView.image = [UIImage imageWithData:anImageData];
        break;
      }
        
      default:
      {
        NSString *message = @"Can't upload avatar.";
        [RPGAlertController showAlertWithTitle:nil
                                       message:message
                                   actionTitle:nil
                                    completion:nil];
        break;
      }
    }
  }];
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


- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  return UIInterfaceOrientationMaskLandscape;
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

- (IBAction)back:(UIButton *)sender
{
  [self setViewToWaitingStateWithMessage:kRPGCharacterProfileViewControllerWaitingMessageStore];
  
  NSUInteger characterID = [NSUserDefaults standardUserDefaults].characterID;
  NSArray *skills = self.skillCollectionViewController.skillsIDArray;
  
  RPGSkillsSelectRequest *request = [RPGSkillsSelectRequest skillSelectRequestWithCharacterID:characterID skills:skills];
  [[RPGNetworkManager sharedNetworkManager] selectSkillsWithRequest:request
                                                  completionHandler:^void(RPGStatusCode networkStatusCode, RPGSkillsResponse *aResponse)
   {
     [self setViewToNormalState];
     
     switch (aResponse.status)
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
