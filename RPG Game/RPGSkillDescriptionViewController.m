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
  // Entities
#import "RPGSkillRepresentation.h"
  // Constants
#import "RPGNibNames.h"

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
  self.effectsCollectionViewController = [[[RPGSkillsEffectsCollectionViewController alloc]
                                           initWithCollectionView:self.effectsCollectionView
                                           skillsEffects:aSkillRepresentation.effects
                                           align:kRPGSkillsEffectsCollectionViewAlignRight] autorelease];
}

#pragma mark - Actions

- (IBAction)removeViewControllerFromParent:(UITapGestureRecognizer *)aRecognizer
{
  [self.view removeFromSuperview];
  [self removeFromParentViewController];
}

@end
