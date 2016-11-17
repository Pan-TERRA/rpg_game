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

@interface RPGCharacterProfileViewController ()

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

- (void)dealloc
{
  [_skillCollectionViewController release];
  
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
  
  //test data
  ((RPGSkillCollectionViewController *)_skillCollectionViewController).skillColectionSize = 3;
  ((RPGBagCollectionViewController *)_bagCollectionViewController).bagCollectionSize = 8;
  
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  return UIInterfaceOrientationMaskLandscape;
}

- (IBAction)back:(UIButton *)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
