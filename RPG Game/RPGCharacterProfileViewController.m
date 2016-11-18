//
//  RPGCharacterProfileViewController.m
//  RPG Game
//
//  Created by Максим Шульга on 11/16/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGCharacterProfileViewController.h"
#import "RPGNibNames.h"
#import "RPGCharacterBagCollectionViewCell.h"
#import "RPGCollectionViewController.h"
#import "RPGSkillCollectionViewController.h"
#import "RPGBagCollectionViewController.h"
#import "RPGProgressBar.h"
#import "RPGNetworkManager+CharacterProfile.h"
#import "RPGCharacterRequest.h"
#import "RPGCharacterProfileInfoResponse.h"
#import "NSUserDefaults+RPGSessionInfo.h"
#import "RPGAlert.h"
#import "RPGSkill.h"

@interface RPGCharacterProfileViewController ()

@property (nonatomic, assign, readwrite) IBOutlet UILabel *levelLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *expLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *hpLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *attackLabel;
@property (nonatomic, assign, readwrite) IBOutlet RPGProgressBar *expProgressBar;

@property (nonatomic, assign, readwrite) IBOutlet UICollectionView *skillCollectionView;
@property (nonatomic, assign, readwrite) IBOutlet UICollectionView *bagCollectionView;

@property (nonatomic, retain, readwrite) RPGCollectionViewController *skillCollectionViewController;
@property (nonatomic, retain, readwrite) RPGCollectionViewController *bagCollectionViewController;

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
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_skillCollectionViewController release];
  [_bagCollectionViewController release];

  [super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UINib *cellNib = [UINib nibWithNibName:kRPGCharacterBagCollectionViewCellNIBName bundle:nil];
  [self.skillCollectionView registerNib:cellNib forCellWithReuseIdentifier:kRPGCharacterBagCollectionViewCellNIBName];
  [self.bagCollectionView registerNib:cellNib forCellWithReuseIdentifier:kRPGCharacterBagCollectionViewCellNIBName];
  
  self.skillCollectionViewController.viewController = self;
  self.skillCollectionViewController.collectionView = self.skillCollectionView;
  self.skillCollectionView.dataSource = self.skillCollectionViewController;
  self.skillCollectionView.delegate = self.skillCollectionViewController;
  
  self.bagCollectionViewController.viewController = self;
  self.bagCollectionViewController.collectionView = self.bagCollectionView;
  self.bagCollectionView.dataSource = self.bagCollectionViewController;
  self.bagCollectionView.delegate = self.bagCollectionViewController;
  
  void (^handler)(RPGCharacterProfileInfoResponse *) = ^void(RPGCharacterProfileInfoResponse *aResponse)
  {
    switch (aResponse.status)
    {
      case kRPGStatusCodeOK:
      {
        self.levelLabel.text = [NSString stringWithFormat:@"%d", aResponse.currentLevel];
        self.expLabel.text = [NSString stringWithFormat:@"%d/%d", aResponse.currentExp, aResponse.maxExp];
        self.hpLabel.text = [NSString stringWithFormat:@"%d", aResponse.hp];
        self.attackLabel.text = [NSString stringWithFormat:@"%d", aResponse.attack];
        self.skillCollectionViewController.collectionSize = aResponse.activeSkillsBagSize;
        self.bagCollectionViewController.collectionSize = aResponse.bagSize;
        self.expProgressBar.progress = (CGFloat)aResponse.currentExp / aResponse.maxExp;
        
        NSArray *skillsArray = aResponse.skills;
        NSMutableArray *skillCollectionArray = [NSMutableArray array];
        NSMutableArray *bagCollectionArray = [NSMutableArray array];
        for (RPGSkill *skill in skillsArray)
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
  
  NSUserDefaults *stansartUserDefaults = [NSUserDefaults standardUserDefaults];
  NSString *token = stansartUserDefaults.sessionToken;
  NSUInteger characterID = [[[stansartUserDefaults.sessionCharacters firstObject] objectForKey:@"char_id"] integerValue];
  RPGCharacterRequest *request = [RPGCharacterRequest characterRequestWithToken:token characterID:characterID];
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

#pragma mark - Actions

- (IBAction)back:(UIButton *)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Add To Collection

- (void)addToSkillCollectionSkillWithID:(NSUInteger)aSkillID
{
  [self.skillCollectionViewController addSkill:aSkillID];
}

- (void)addToBagCollectionSkillWithID:(NSUInteger)aSkillID
{
  [self.bagCollectionViewController addSkill:aSkillID];
}

@end
