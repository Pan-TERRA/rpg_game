//
//  RPGProofImageViewController.m
//  RPG Game
//
//  Created by Максим Шульга on 10/14/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestProofImageViewController.h"
#import "RPGNibNames.h"

@interface RPGQuestProofImageViewController ()

@property (nonatomic, assign, readwrite) IBOutlet UIImageView *proofImageView;

@end

@implementation RPGQuestProofImageViewController

#pragma mark - Init

- (instancetype)init
{
  return [super initWithNibName:kRPGQuestProofImageViewController
                         bundle:nil];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

#pragma mark - Event Handling

- (IBAction)backButtonOnClicked:(UIButton *)aSender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - set view content

- (void)setImage:(UIImage *)anImage
{
  self.proofImageView.image = anImage;
}

@end