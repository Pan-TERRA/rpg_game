//
//  RPGProofImageViewController.m
//  RPG Game
//
//  Created by Максим Шульга on 10/14/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestProofImageViewController.h"
  // Constants
#import "RPGNibNames.h"

@interface RPGQuestProofImageViewController ()

@property (nonatomic, assign, readwrite) IBOutlet UIImageView *proofImageView;
@property (nonatomic, assign, readwrite) IBOutlet NSLayoutConstraint *topImageViewConstraint;
@property (nonatomic, assign, readwrite) IBOutlet NSLayoutConstraint *bottomImageViewConstraint;
@property (nonatomic, assign, readwrite) IBOutlet NSLayoutConstraint *leadingImageViewConstraint;
@property (nonatomic, assign, readwrite) IBOutlet NSLayoutConstraint *trailingImageViewConstraint;

@end

@implementation RPGQuestProofImageViewController

#pragma mark - Init

- (instancetype)init
{
  return [super initWithNibName:kRPGQuestProofImageViewControllerNIBName
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

#pragma mark - IBActions

- (IBAction)backButtonOnClicked:(UIButton *)aSender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Set View Content

- (void)setImage:(UIImage *)anImage
{
  CGSize imageSize = anImage.size;
  CGSize viewSize = self.view.frame.size;
  NSUInteger topBottomConst = 0;
  NSUInteger leftRightConst = 0;
  
  if (imageSize.width / imageSize.height <= viewSize.width / viewSize.height)
  {
    CGFloat imageWidth = imageSize.width * viewSize.height / imageSize.height;
    leftRightConst = (viewSize.width -  imageWidth) / 2.0;
  }
  else
  {
    CGFloat imageHeight = imageSize.height * viewSize.width / imageSize.width;
    topBottomConst = (viewSize.height -  imageHeight) / 2.0;
  }
  
  self.topImageViewConstraint.constant = topBottomConst;
  self.bottomImageViewConstraint.constant = topBottomConst;
  self.leadingImageViewConstraint.constant = leftRightConst;
  self.trailingImageViewConstraint.constant = leftRightConst;
  
  self.proofImageView.image = anImage;
}

@end
