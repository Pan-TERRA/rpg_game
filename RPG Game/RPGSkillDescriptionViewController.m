//
//  RPGSkillDescriptionViewController.m
//  RPG Game
//
//  Created by Владислав Крут on 11/8/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillDescriptionViewController.h"
  // Controllers
#import "RPGSkillsEffectsCollectionViewController.h"
#import "RPGSkillEffectDescriptionViewController.h"
#import "UIViewController+RPGChildViewController.h"
#import "RPGSkillsEffectsCollectionViewCell.h"
  // Entities
#import "RPGSkillRepresentation.h"
#import "RPGSkillEffectRepresentation.h"
  // Constants
#import "RPGNibNames.h"
#import "RPGAlign.h"

@interface RPGSkillDescriptionViewController ()

@property (nonatomic, assign, readwrite) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *cooldownLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *multiplierLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, assign, readwrite) IBOutlet UICollectionView *effectsCollectionView;

@property (nonatomic, retain, readwrite) RPGSkillsEffectsCollectionViewController *effectsCollectionViewController;

@end

@implementation RPGSkillDescriptionViewController

#pragma mark - Init

- (instancetype)init
{
  return [super initWithNibName:kRPGSkillDescriptionViewControllerNIBName
                         bundle:nil];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_effectsCollectionViewController release];
  
  [super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UINib *cellNIB = [UINib nibWithNibName:kRPGSkillsEffectsCollectionViewCellNIBName
                                  bundle:nil];
  [self.effectsCollectionView registerNib:cellNIB
               forCellWithReuseIdentifier:kRPGSkillsEffectsCollectionViewCellNIBName];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

#pragma mark - 

- (void)setViewContent:(RPGSkillRepresentation *)aSkillRepresentation
{
  self.titleLabel.text = aSkillRepresentation.name;
  self.cooldownLabel.text = [NSString stringWithFormat:@"%lu", (long)aSkillRepresentation.cooldown];
  self.multiplierLabel.text = [NSString stringWithFormat:@"%2.2f", aSkillRepresentation.multiplier];
  self.descriptionLabel.text = aSkillRepresentation.skillDescription;
  self.effectsCollectionViewController = [RPGSkillsEffectsCollectionViewController
                                           skillEffectsControllerWithCollectionView:self.effectsCollectionView
                                           skillsEffects:aSkillRepresentation.effects
                                           align:kRPGAlignRight];
}

#pragma mark - Actions

- (IBAction)handleTapGesture:(UITapGestureRecognizer *)aRecognizer
{
  UICollectionView *collectionView = self.effectsCollectionView;
  CGPoint point = [aRecognizer locationInView:collectionView];
  NSIndexPath *path = [collectionView indexPathForItemAtPoint:point];
  RPGSkillsEffectsCollectionViewCell *cell = (RPGSkillsEffectsCollectionViewCell *)[collectionView cellForItemAtIndexPath:path];
  
  if (cell != nil)
  {
    RPGSkillEffectDescriptionViewController *skillEffectDescriptionViewController = [[[RPGSkillEffectDescriptionViewController alloc] init] autorelease];
    
    RPGSkillEffectRepresentation *skillEffectRepresentation = [[[RPGSkillEffectRepresentation alloc] initWithSkillEffectID:cell.skillEffectID] autorelease];
    
    UIViewController *parentViewController = self.parentViewController;
    [parentViewController addChildViewController:skillEffectDescriptionViewController
                                           frame:parentViewController.view.frame];
    
    [skillEffectDescriptionViewController setViewContent:skillEffectRepresentation];
  }
  else
  {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
  }
}

@end
