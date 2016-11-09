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
  if (self)
  {
    _skillRepresentation = [aSkillRepresentation retain];
    _titleLabel.text = aSkillRepresentation.name;
    _cooldownLabel.text = [NSString stringWithFormat:@"%lu",aSkillRepresentation.absoluteCooldown];
    _multiplierLabel.text = [NSString stringWithFormat:@"%2.2f",aSkillRepresentation.multiplier];
    _descriptionLabel.text = aSkillRepresentation.skillDescription;
  }
  return self;
}

- (instancetype)init
{
  return [super initWithNibName:@"RPGSkillDescriptionViewController" bundle:nil];
}

#pragma mark - Dealloc
- (void)dealloc
{
  [_skillRepresentation release];
  
  [super dealloc];
}

#pragma mark - UIViewController
- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.descriptionLabel sizeToFit];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

@end
