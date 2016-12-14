//
//  RPGAvatarSelectViewController.m
//  RPG Game
//
//  Created by Максим Шульга on 12/1/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAvatarSelectViewController.h"
  // API
#import "RPGNetworkManager+CharacterProfile.h"
  // Controllers
#import "RPGCharacterProfileViewController.h"
#import "RPGAvatarCollectionViewController.h"
  // Views
#import "RPGAvatarCollectionViewCell.h"
  // Entities
#import "RPGCharacterAvatarSelectRequest.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"
#import "UIViewController+RPGWrongTokenHandling.h"
  // Constants
#import "RPGNibNames.h"

static NSString * const kRPGAvatarSelectViewControllerAvatarID = @"avatar_id";

@interface RPGAvatarSelectViewController ()

@property (nonatomic, assign, readwrite) IBOutlet UICollectionView *avatarSelectCollectionView;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *avatarSelectButton;
@property (nonatomic, retain, readwrite) RPGAvatarCollectionViewController *avatarCollectionViewController;

@end

@implementation RPGAvatarSelectViewController

#pragma mark - Init

- (instancetype)init
{
  self = [super initWithNibName:kRPGAvatarSelectViewControllerNIBName
                         bundle:nil];
  
  if (self != nil)
  {
    _avatarCollectionViewController = [[RPGAvatarCollectionViewController alloc] init];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_avatarCollectionViewController release];
  
  [super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
  NSInteger characterAvatarID = standardUserDefaults.characterAvatarID - 1;
  
  UINib *avatarCellNIB = [UINib nibWithNibName:kRPGAvatarCollectionViewCellNIBName
                                        bundle:nil];
  [self.avatarSelectCollectionView registerNib:avatarCellNIB
                    forCellWithReuseIdentifier:kRPGAvatarCollectionViewCellNIBName];
  
  self.avatarCollectionViewController = [[[RPGAvatarCollectionViewController alloc]
                                          initWithCollectionView:self.avatarSelectCollectionView
                                          selectedAvatarIndex:characterAvatarID] autorelease];
  self.avatarCollectionViewController.characterClassID = standardUserDefaults.characterClassID;
}

- (void)viewWillAppear:(BOOL)anAnimated
{
  [super viewWillAppear:anAnimated];
  
  NSIndexPath *path = [NSIndexPath indexPathForRow:self.avatarCollectionViewController.selectedAvatarIndex
                                         inSection:0];
  [self.avatarSelectCollectionView scrollToItemAtIndexPath:path
                                          atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                                  animated:YES];
}

#pragma mark - IBActions

- (IBAction)selectAvatarButtonOnClick:(UIButton *)aSender
{
  NSInteger index = self.avatarCollectionViewController.selectedAvatarIndex + 1;
  RPGCharacterAvatarSelectRequest *request = [RPGCharacterAvatarSelectRequest characterAvatarSelectRequestWithAvatarID:index];
  
  [[RPGNetworkManager sharedNetworkManager] characterAvatarSelectWithRequest:request
                                                           completionHandler:^(RPGStatusCode aNetworkStatusCode)
   {
     switch (aNetworkStatusCode)
     {
       case kRPGStatusCodeOK:
       {
         [self saveSelectedAvatarID:index];
         break;
       }
         
       case kRPGStatusCodeWrongToken:
       {
         [self handleWrongTokenError];
         break;
       }
         
       default:
       {
         [self.delegate handleDefaultError];
         break;
       }
     }
     
     [self.view removeFromSuperview];
     [self removeFromParentViewController];
   }];
}

#pragma mark - Save To UserDefaults

- (void)saveSelectedAvatarID:(NSUInteger)anAvatarID
{
  NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
  NSMutableArray *characters = [[standardUserDefaults.sessionCharacters mutableCopy] autorelease];
  NSMutableDictionary *character = [[[characters firstObject] mutableCopy] autorelease];
  
  character[kRPGAvatarSelectViewControllerAvatarID] = @(anAvatarID);
  characters[0] = character;
  
  standardUserDefaults.sessionCharacters = characters;
  [self.delegate updateCharacterAvatar];
}

@end
