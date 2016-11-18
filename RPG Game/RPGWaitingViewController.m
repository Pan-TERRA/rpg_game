//
//  RPGWaitingViewController.m
//  RPG Game
//
//  Created by Максим Шульга on 11/18/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGWaitingViewController.h"
#import "RPGNibNames.h"

@interface RPGWaitingViewController ()

@property (nonatomic, assign, readwrite) IBOutlet UILabel *messageLabel;
@property (nonatomic, copy, readwrite) NSString *message;

@end

@implementation RPGWaitingViewController

#pragma mark - Init

- (instancetype)init
{
  return [super initWithNibName:kRPGWaitingViewControllerNIBName bundle:nil];
}

- (instancetype)initWithMessage:(NSString *)aMessage
{
  self = [self init];
  
  if (self != nil)
  {
    _message = [aMessage copy];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_message release];
  
  [super dealloc];
}

#pragma mark - UICollectionView

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.messageLabel.text = self.message;
}

#pragma mark - Actions

- (IBAction)back:(UIButton *)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
