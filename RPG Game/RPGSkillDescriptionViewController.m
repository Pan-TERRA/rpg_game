//
//  RPGSkillDescriptionViewController.m
//  RPG Game
//
//  Created by Владислав Крут on 11/8/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillDescriptionViewController.h"
#import "RPGSkillRepresentation.h"

@interface RPGSkillDescriptionViewController ()

@property (nonatomic, assign, readwrite) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *cooldownLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *multiplierLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *descriptionLabel;

@property (nonatomic, retain, readwrite) RPGSkillRepresentation* skillRepresentation;

@end

@implementation RPGSkillDescriptionViewController

#pragma mark - Init

- (instancetype)initWithSkillRepresentation:(RPGSkillRepresentation *)aSkillRepresentation
{
  self = [self init];
  
  if (self != nil)
  {
    _skillRepresentation = [aSkillRepresentation retain];
  }
  
  return self;
}

- (instancetype)init
{
  return [super initWithNibName:@"RPGSkillDescriptionViewController" bundle:nil];
}

+ (instancetype)viewControllerWithSkillRepresentation:(RPGSkillRepresentation *)aSkillRepresentation
{
  return [[[self alloc] initWithSkillRepresentation:aSkillRepresentation] autorelease];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_skillRepresentation release];
  
  [super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidAppear:(BOOL)isAnimated
{
  [super viewDidAppear:isAnimated];
  
  RPGSkillRepresentation *skill = self.skillRepresentation;
  self.titleLabel.text = skill.name;
  self.cooldownLabel.text = [NSString stringWithFormat:@"%lu", skill.absoluteCooldown];
  self.multiplierLabel.text = [NSString stringWithFormat:@"%2.2f", skill.multiplier];
  self.descriptionLabel.text = skill.skillDescription;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

@end
