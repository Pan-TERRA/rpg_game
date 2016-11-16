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

@interface RPGCharacterProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, assign, readwrite) IBOutlet UIView *skillBar;
@property (nonatomic, assign, readwrite) IBOutlet UICollectionView *collectionView;

@end

@implementation RPGCharacterProfileViewController

#pragma mark - Init

- (instancetype)init
{
  return [super initWithNibName:kRPGCharacterProfileViewControllerNIBName bundle:nil];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UINib *cellNib = [UINib nibWithNibName:kRPGCharacterBagCollectionViewCellNIBName bundle:nil];
  [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:kRPGCharacterBagCollectionViewCellNIBName];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  return UIInterfaceOrientationMaskLandscape;
}

- (void)dealloc
{
  [super dealloc];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return 8;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  
  RPGCharacterBagCollectionViewCell *cell = (RPGCharacterBagCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kRPGCharacterBagCollectionViewCellNIBName forIndexPath:indexPath];
  
  [cell setImage:[UIImage imageNamed:@"_967740272"]];
  
  return cell;
}

- (IBAction)back:(UIButton *)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
