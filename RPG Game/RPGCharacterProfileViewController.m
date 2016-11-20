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
  // Views
#import "RPGCharacterBagCollectionViewCell.h"
#import "RPGProgressBar.h"
  // Entities
#import "RPGCharacterRequest.h"
#import "RPGCharacterProfileInfoResponse.h"
#import "RPGCharacterProfileSkill.h"
#import "RPGSkillsResponse.h"
#import "RPGSkillsSelectRequest.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"
#import "RPGAlert.h"
  // Constants
#import "RPGNibNames.h"

@interface RPGCharacterProfileViewController ()

@property (nonatomic, assign, readwrite) IBOutlet UILabel *nickNameLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *levelLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *expLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *hpLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *attackLabel;
@property (nonatomic, assign, readwrite) IBOutlet RPGProgressBar *expProgressBar;
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
    _waitingModal = [[RPGWaitingViewController alloc] initWithMessage:@"Uploading info"];
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

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UINib *cellNIB = [UINib nibWithNibName:kRPGCharacterBagCollectionViewCellNIBName bundle:nil];
  [self.skillCollectionView registerNib:cellNIB forCellWithReuseIdentifier:kRPGCharacterBagCollectionViewCellNIBName];
  [self.bagCollectionView registerNib:cellNIB forCellWithReuseIdentifier:kRPGCharacterBagCollectionViewCellNIBName];
  
  self.skillCollectionViewController.viewController = self;
  self.skillCollectionViewController.collectionView = self.skillCollectionView;
  self.skillCollectionView.dataSource = self.skillCollectionViewController;
  self.skillCollectionView.delegate = self.skillCollectionViewController;
  
  self.bagCollectionViewController.viewController = self;
  self.bagCollectionViewController.collectionView = self.bagCollectionView;
  self.bagCollectionView.dataSource = self.bagCollectionViewController;
  self.bagCollectionView.delegate = self.bagCollectionViewController;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  [self setViewToWaitingState];
  
 
  
  void (^handler)(RPGStatusCode, RPGCharacterProfileInfoResponse *) = ^void(RPGStatusCode networkStatusCode, RPGCharacterProfileInfoResponse *aResponse)
  {
    [self setViewToNormalState];
    
    switch (aResponse.status)
    {
      case kRPGStatusCodeOK:
      {
        self.nickNameLabel.text = [[[NSUserDefaults standardUserDefaults].sessionCharacters firstObject] objectForKey:@"name"];
        self.levelLabel.text = [NSString stringWithFormat:@"%d", aResponse.currentLevel];
        self.expLabel.text = [NSString stringWithFormat:@"%d/%d", aResponse.currentExp, aResponse.maxExp];
        self.hpLabel.text = [NSString stringWithFormat:@"%d", aResponse.hp];
        self.attackLabel.text = [NSString stringWithFormat:@"%d", aResponse.attack];
        
        self.skillCollectionViewController.collectionSize = aResponse.activeSkillsBagSize;
        self.bagCollectionViewController.collectionSize = aResponse.bagSize;
        //self.expProgressBar.progress = (CGFloat)aResponse.currentExp / aResponse.maxExp;
        
        NSArray *skillsArray = aResponse.skills;
        NSMutableArray *skillCollectionArray = [NSMutableArray array];
        NSMutableArray *bagCollectionArray = [NSMutableArray array];
        for (RPGCharacterProfileSkill *skill in skillsArray)
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
        
        self.skillCollectionViewController.skillsIDArray = skillCollectionArray;
        self.bagCollectionViewController.skillsIDArray = bagCollectionArray;
        break;
      }
        
      case kRPGStatusCodeWrongToken:
      {
        NSString *message = @"Can't update quest list.\nWrong token error.\nTry to log in again.";
        [RPGAlert showAlertWithTitle:@"Error" message:message completion:^(void)
         {
           UIViewController *viewController = self.presentingViewController.presentingViewController;
           [viewController dismissViewControllerAnimated:YES completion:nil];
         }];
        break;
      }
        
      default:
      {
        NSString *message = @"Can't upload quest proof image.";
        [RPGAlert showAlertWithTitle:@"Error" message:message completion:nil];
        break;
      }
    }
  };
  
  NSInteger characterID = [NSUserDefaults standardUserDefaults].characterID;
  
  RPGCharacterRequest *request = [RPGCharacterRequest characterRequestWithCharacterID:characterID];
  [[RPGNetworkManager sharedNetworkManager] getCharacterProfileInfoWithRequest:request completionHandler:handler];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  return UIInterfaceOrientationMaskLandscape;
}

#pragma mark - View State

- (void)setViewToWaitingState
{
  self.waitingModal.message = @"Storing skills";
  [self addChildViewController:self.waitingModal];
  self.waitingModal.view.frame = self.view.frame;
  [self.view addSubview:self.waitingModal.view];
  [self.waitingModal didMoveToParentViewController:self];
}

- (void)setViewToNormalState
{
  [self.waitingModal.view removeFromSuperview];
  [self.waitingModal removeFromParentViewController];
}

#pragma mark - Actions

- (IBAction)back:(UIButton *)sender
{
  [self setViewToWaitingState];
  
  void (^handler)(RPGStatusCode, RPGSkillsResponse *) = ^void(RPGStatusCode networkStatusCode, RPGSkillsResponse *aResponse)
  {
    [self setViewToNormalState];
    
      // TODO: redo status validation
    switch (aResponse.status)
    {
      case kRPGStatusCodeOK:
      {
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *characters = [[standardUserDefaults.sessionCharacters mutableCopy] autorelease];
        NSMutableDictionary *character = [[[characters firstObject] mutableCopy] autorelease];
        
        character[@"skills"] = self.skillCollectionViewController.skillsIDArray;
        characters[0] = character;
        
        standardUserDefaults.sessionCharacters = characters;
        [self dismissViewControllerAnimated:YES completion:nil];
        break;
      }
        
      case kRPGStatusCodeWrongToken:
      {
        NSString *message = @"Can't select skills.\nWrong token error.\nTry to log in again.";
        [RPGAlert showAlertWithTitle:@"Error" message:message completion:^(void)
        {
          UIViewController *viewController = self.presentingViewController.presentingViewController;
          [viewController dismissViewControllerAnimated:YES completion:nil];
        }];
        break;
      }
        
      default:
      {
        NSString *message = @"Can't select skills.";
        [RPGAlert showAlertWithTitle:@"Error" message:message completion:^(void)
        {
          [self dismissViewControllerAnimated:YES completion:nil];
        }];
        break;
      }
    }
  };
  
  NSUInteger characterID = [NSUserDefaults standardUserDefaults].characterID;
  NSArray *skills = self.skillCollectionViewController.skillsIDArray;
  
  RPGSkillsSelectRequest *request = [RPGSkillsSelectRequest skillSelectRequestWithCharacterID:characterID skills:skills];
  [[RPGNetworkManager sharedNetworkManager] selectSkillsWithRequest:request completionHandler:handler];
}

#pragma mark - Add To Collection

- (void)addSkillToSkillCollectionWithID:(NSUInteger)anItemID type:(RPGItemType)aType;
{
  [self.skillCollectionViewController addItem:anItemID type:aType];
  [self setCancelButtonState];
}

- (void)addItemToBagCollectionWithID:(NSUInteger)aSkillID type:(RPGItemType)aType;
{

  [self.bagCollectionViewController addItem:aSkillID type:aType];
  [self setCancelButtonState];
}

- (void)setCancelButtonState
{
  self.backButton.enabled = !(self.skillCollectionViewController.skillsIDArray.count == 0);
}

@end
