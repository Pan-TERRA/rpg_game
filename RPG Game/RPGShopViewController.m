//
//  RPGShopViewController.m
//  RPG Game
//
//  Created by Владислав Крут on 11/23/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGShopViewController.h"
  //view
#import "RPGShopCollectionViewController.h"
  //support
#import "UIViewController+RPGChildViewController.h"
  //constants
#import "RPGNibNames.h"

@interface RPGShopViewController ()

@property (nonatomic, assign, readwrite) IBOutlet UIView *collectionViewContainer;
@property(nonatomic, retain, readwrite) RPGShopCollectionViewController *collectionViewController;

@end

@implementation RPGShopViewController

#pragma mark - Init

- (instancetype)init
{
  self = [self initWithNibName:kRPGShopViewControllerNIBName bundle:nil];
  if (self != nil)
  {
    _collectionViewController = [RPGShopCollectionViewController new];
  }
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  [self addChildViewController:self.collectionViewController frame:self.collectionViewContainer.frame];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

#pragma mark - IBActions

- (IBAction)back:(UIButton *)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}


@end
