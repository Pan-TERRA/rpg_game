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
#import "RPGConfirmViewController.h"
  // Support
#import "UIViewController+RPGChildViewController.h"
  // API
#import "RPGNetworkManager+Shop.h"
#import "RPGShopUnitsResponse.h"
#import "RPGShopUnitRequest.h"
  // Entity
#import "RPGShopUnit.h"
#import "RPGShopUnitRepresetation.h"
#import "RPGResources.h"
#import "RPGResourcesResponse.h"
  // Constants
#import "RPGNibNames.h"
#import "RPGStatusCodes.h"
  // Misc
#import "RPGAlertController.h"
#import "NSUserDefaults+RPGSessionInfo.h"
#import "UIViewController+RPGWrongTokenHandling.h"

typedef void (^fetchShopUnitsCompletionHandler)(RPGStatusCode aNetworkStatusCode, NSArray<NSDictionary *> *aShopUnits);
typedef void (^buyShopUnitCompletionHandler)(RPGStatusCode aNetworkStatusCode);

static NSString * const sRPGShopViewControllerLoadingMessage = @"Loading...";
static NSString * const sRPGShopViewControllerConfirmQuestion = @"Are you sure you want to buy this unit?";

@interface RPGShopViewController () <RPGShopCollectionViewControllerDelegate>

@property (nonatomic, assign, readwrite) IBOutlet UILabel *goldLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *crystallLabel;
  // Views
@property (nonatomic, assign, readwrite) IBOutlet UIView *collectionViewContainer;
@property (nonatomic, retain, readwrite) RPGShopCollectionViewController *collectionViewController;
  // Modals
@property (nonatomic, retain, readwrite) RPGWaitingViewController *shopInitModal;
@property (nonatomic, retain, readwrite) RPGConfirmViewController *shopConfirmModal;

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
    _collectionViewController.delegate = self;
    _shopInitModal = [[RPGWaitingViewController alloc] initWithMessage:sRPGShopViewControllerLoadingMessage
                                                            completion:nil];
    _shopConfirmModal = [RPGConfirmViewController new];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_collectionViewController release];
  [_shopInitModal release];
  [_shopConfirmModal release];
  
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

  [self updateViewsWithWaitingModal];
}

- (void)viewDidLayoutSubviews
{
  [super viewDidLayoutSubviews];

  self.collectionViewController.view.frame = self.collectionViewContainer.frame;
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
  fetchShopUnitsCompletionHandler handler= ^void(RPGStatusCode aNetworkStatusCode,
                                                 NSArray<NSDictionary *> *aShopUnits)
  {
    
    switch (aNetworkStatusCode)
    {
      case kRPGStatusCodeOK:
      {
        NSMutableArray<RPGShopUnitRepresetation *> *shopUnitRepresentations = [NSMutableArray array];
        
        for (NSDictionary *shopUnitDictionary in aShopUnits)
        {
          RPGShopUnit *shopUnit = [[[RPGShopUnit alloc] initWithDictionaryRepresentation:shopUnitDictionary] autorelease];
          RPGShopUnitRepresetation *representation = [RPGShopUnitRepresetation shopUnitRepresetationWithShopUnit:shopUnit];
          [shopUnitRepresentations addObject:representation];
        }
        self.collectionViewController.shopUnits = shopUnitRepresentations;
        break;
      }
        case kRPGStatusCodeWrongToken:
      {
        [self handleWrongTokenError];
        
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
    [self.collectionViewController.collectionView reloadData];
    
    [self removeShopInitModal];
  };
  
  [[RPGNetworkManager sharedNetworkManager] fetchShopUnitsWithCompletionHandler:handler];
}

- (void)buyShopUnitWithID:(NSInteger)anUnitID
{
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
        [self handleWrongTokenError];
        
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
       if (aNetworkStatusCode == kRPGStatusCodeOK)
       {
         RPGResources *resources = aResponse.resources;
         NSUserDefaults *standartUserDefaults = [NSUserDefaults standardUserDefaults];
         standartUserDefaults.sessionGold = resources.gold;
         standartUserDefaults.sessionCrystals = resources.crystals;
         
         [self updateResourcesLabels];
       }
     }];
    
    [self removeShopInitModal];
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

#pragma mark - RPGShopCollectionViewControllerDelegate

- (void)buyButtonDidPress:(RPGShopCollectionViewController *)aCollectionViewController
           withShopUnitID:(NSInteger)aShopUnitID
{
  self.shopConfirmModal.question = sRPGShopViewControllerConfirmQuestion;
  
  self.shopConfirmModal.completionHandler = ^void(void)
  {
    [self addChildViewController:self.shopInitModal
                               frame:self.view.frame];
    
    [self buyShopUnitWithID:aShopUnitID];
  };

  [self addChildViewController:self.shopConfirmModal view:self.view];
}

@end
