//
//  RPGProofImageViewController.m
//  RPG Game
//
//  Created by Максим Шульга on 10/14/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestProofImageViewController.h"

@interface RPGQuestProofImageViewController ()

@property (nonatomic, assign, readwrite) IBOutlet UIImageView *proofImageView;

@end

@implementation RPGQuestProofImageViewController

#pragma mark - UIViewController Methods

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

#pragma mark - Event Handling

- (IBAction)backButtonOnClicked:(UIButton *)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - set view content 
- (void)setImage:(UIImage *)image
{
  self.proofImageView.image = image;
}

@end