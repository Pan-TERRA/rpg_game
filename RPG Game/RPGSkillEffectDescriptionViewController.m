//
//  RPGSkillEffectDescriptionViewController.m
//  RPG Game
//
//  Created by Максим Шульга on 12/9/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillEffectDescriptionViewController.h"
  // Entities
#import "RPGSkillEffectRepresentation.h"

static CGFloat const kRPGSkillEffectDescriptionViewControllerViewCornerRadiusMultiplier = 0.5;

@interface RPGSkillEffectDescriptionViewController ()

@property (nonatomic, assign, readwrite) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *imageView;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *descriptionLabel;

@end

@implementation RPGSkillEffectDescriptionViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (void)setViewContent:(RPGSkillEffectRepresentation *)aSkillEffectRepresentation
{
  self.titleLabel.text = aSkillEffectRepresentation.name;
  self.imageView.image = [UIImage imageNamed:aSkillEffectRepresentation.imageName];
  self.descriptionLabel.text = aSkillEffectRepresentation.skillEffectDescription;
  self.imageView.image = [UIImage imageNamed:@"battle_empty_icon_inactive"];
  self.backgroundImageView.image = [UIImage imageNamed:aSkillEffectRepresentation.imageName];
  
  self.backgroundImageView.layer.cornerRadius = self.backgroundImageView.frame.size.width * kRPGSkillEffectDescriptionViewControllerViewCornerRadiusMultiplier;
  self.backgroundImageView.layer.masksToBounds = YES;
}

#pragma mark - Actions

- (IBAction)handleTapGesture:(UITapGestureRecognizer *)aSender
{
  [self.view removeFromSuperview];
  [self removeFromParentViewController];
}

@end
