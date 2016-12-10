//
//  RPGShopViewController.m
//  RPG Game
//
//  Created by Владислав Крут on 11/23/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGShopViewController.h"
  // Views
#import "RPGShopCollectionViewController.h"
#import "RPGWaitingViewController.h"
  // Support
#import "UIViewController+RPGChildViewController.h"
  // API
#import "RPGNetworkManager+Shop.h"
#import "RPGShopUnitsResponse.h"
  // Entity
#import "RPGShopUnit.h"
#import "RPGResources.h"
#import "RPGResourcesResponse.h"
#import "RPGShopUnitRequest.h"
  // Constants
#import "RPGNibNames.h"
#import "RPGStatusCodes.h"
  // Misc
#import "RPGAlertController.h"
#import "NSUserDefaults+RPGSessionInfo.h"

typedef void (^fetchShopUnitsCompletionHandler)(RPGStatusCode aNetworkStatusCode, RPGShopUnitsResponse *aResponse);
typedef void (^buyShopUnitCompletionHandler)(RPGStatusCode aNetworkStatusCode);

static NSString * const sRPGShopViewControllerLoadingMessage = @"Loading...";

@interface RPGShopViewController ()

@property (nonatomic, assign, readwrite) IBOutlet UILabel *goldLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *crystallLabel;
  // Views
@property (nonatomic, assign, readwrite) IBOutlet UIView *collectionViewContainer;
@property (nonatomic, retain, readwrite) RPGShopCollectionViewController *collectionViewController;
  // Modals
@property (nonatomic, retain, readwrite) RPGWaitingViewController *shopInitModal;

@end

@implementation RPGShopViewController

#pragma mark - Init

- (instancetype)init
{
  self = [self initWithNibName:kRPGShopViewControllerNIBName
                        bundle:nil];
  
  if (self != nil)
  {
    _collectionViewController = [[RPGShopCollectionViewController alloc] init];
    _shopInitModal = [[RPGWaitingViewController alloc] initWithMessage:sRPGShopViewControllerLoadingMessage
                                                            completion:nil];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_collectionViewController release];
  [_shopInitModal release];
  
  [super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self addChildViewController:self.collectionViewController
                         frame:self.collectionViewContainer.frame];
}

- (void)viewWillAppear:(BOOL)anAnimated
{
  [super viewWillAppear:anAnimated];
  
  NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
  self.goldLabel.text = [@(userDefault.sessionGold) stringValue];
  self.crystallLabel.text = [@(userDefault.sessionCrystals) stringValue];
  
  self.collectionViewController.view.frame = self.collectionViewContainer.frame;

  [self updateViewsWithWaitingModal];
}

- (void)viewDidAppear:(BOOL)anAnimated
{
  [super viewDidAppear:anAnimated];
}

#pragma mark - IBActions

- (IBAction)back:(UIButton *)aSender
{
  [self dismissViewControllerAnimated:YES
                           completion:nil];
}

- (void)removeShopInitModal
{
  [self.shopInitModal.view removeFromSuperview];
  [self.shopInitModal removeFromParentViewController];
}

- (void)updateViewsWithWaitingModal
{
  [self addChildViewController:self.shopInitModal
                         frame:self.view.frame];
  
  [self fetchShopUnits];
}

#pragma mark - Network

- (void)fetchShopUnits
{
  __block typeof(self) weakSelf = self;
  
  fetchShopUnitsCompletionHandler handler= ^void(RPGStatusCode aNetworkStatusCode,
                                                 RPGShopUnitsResponse *aResponse)
  {
    
    switch (aNetworkStatusCode)
    {
      case kRPGStatusCodeOK:
      {
        NSMutableArray *shopUnits = [NSMutableArray array];
        
        for (NSDictionary *shopUnitDictionary in aResponse.shopUnits)
        {
          RPGShopUnit *shopUnit = [[[RPGShopUnit alloc] initWithDictionaryRepresentation:shopUnitDictionary] autorelease];
          [shopUnits addObject:shopUnit];
        }
        self.collectionViewController.shopUnits = shopUnits;
        break;
      }
        case kRPGStatusCodeWrongToken:
      {
        NSString *message = @"Can't update shop.\nWrong token error.\nTry to log in again.";
        [RPGAlertController showAlertWithTitle:nil
                                       message:message
                                   actionTitle:nil
                                    completion:^(void)
         {
           dispatch_async(dispatch_get_main_queue(), ^
            {
              UIViewController *viewController = weakSelf.presentingViewController.presentingViewController;
              [viewController dismissViewControllerAnimated:YES
                                                 completion:nil];
            });
         }];
        break;
      }
        
      default:
      {
        NSString *message = @"Can't update shop.";
        [RPGAlertController showAlertWithTitle:nil
                                       message:message
                                   actionTitle:nil
                                    completion:nil];
        break;
      }
    }
    [weakSelf.collectionViewController.collectionView reloadData];
    
    [weakSelf removeShopInitModal];
  };
  
  [[RPGNetworkManager sharedNetworkManager] fetchShopUnitsWithCompletionHandler:handler];
}

- (void)buyShopUnitWithID:(NSInteger)anUnitID
{
  __block typeof(self) weakSelf = self;
  
  buyShopUnitCompletionHandler handler= ^void(RPGStatusCode aNetworkStatusCode)
  {
    
    switch (aNetworkStatusCode)
    {
      case kRPGStatusCodeOK:
      {
        [self updateViewsWithWaitingModal];
        
        NSString *message = @"You bought this unit";
        [RPGAlertController showAlertWithTitle:@"Success"
                                       message:message
                                   actionTitle:@"OK"
                                    completion:nil];
        break;
      }
        
      case kRPGStatusCodeWrongToken:
      {
        NSString *message = @"Can't update shop.\nWrong token error.\nTry to log in again.";
        [RPGAlertController showAlertWithTitle:nil
                                       message:message
                                   actionTitle:nil
                                    completion:^(void)
         {
           dispatch_async(dispatch_get_main_queue(), ^
            {
              UIViewController *viewController = weakSelf.presentingViewController.presentingViewController;
              [viewController dismissViewControllerAnimated:YES
                                                 completion:nil];
            });
         }];
        break;
      }
        
      case kRPGStatusCodeNotEnoughMoney:
      {
        NSString *message = @"Not enough money";
        [RPGAlertController showAlertWithTitle:nil
                                       message:message
                                   actionTitle:nil
                                    completion:nil];
        break;
      }
        
      case kRPGStatusCodeUnitIsAlreadyBought:
      {
        NSString *message = @"This unit is already bought";
        [RPGAlertController showAlertWithTitle:nil
                                       message:message
                                   actionTitle:nil
                                    completion:nil];
        break;
      }
        
      default:
      {
        NSString *message = @"Can't buy this unit";
        [RPGAlertController showAlertWithTitle:nil
                                       message:message
                                   actionTitle:nil
                                    completion:nil];
        break;
      }
    }
    
    [[RPGNetworkManager sharedNetworkManager] getResourcesWithCompletionHandler:^(RPGStatusCode aNetworkStatusCode,
                                                                                  RPGResourcesResponse *aResponse)
     {
       if (aNetworkStatusCode == 0)
       {
         RPGResources *resources = aResponse.resources;
         NSUserDefaults *standartUserDefaults = [NSUserDefaults standardUserDefaults];
         standartUserDefaults.sessionGold = resources.gold;
         standartUserDefaults.sessionCrystals = resources.crystals;
         
         [self updateResourcesLabels];
       }
     }];
    
    [weakSelf removeShopInitModal];
  };
  
  RPGShopUnitRequest *request = [RPGShopUnitRequest shopUnitRequestWithShopUnitID:anUnitID];
  [[RPGNetworkManager sharedNetworkManager] buyShopUnitWithRequest:request
                                                 completionHandler:handler];
}

#pragma mark - Helper Methods

- (void)updateResourcesLabels
{
  NSUserDefaults *standartUserDefaults = [NSUserDefaults standardUserDefaults];
  self.goldLabel.text = [NSString stringWithFormat:@"%ld", (long)standartUserDefaults.sessionGold];
  self.crystallLabel.text = [NSString stringWithFormat:@"%ld", (long)standartUserDefaults.sessionCrystals];
}

@end
