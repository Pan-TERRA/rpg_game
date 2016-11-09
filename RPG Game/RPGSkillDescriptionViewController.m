//
//  RPGSkillDescriptionViewController.m
//  RPG Game
//
//  Created by Владислав Крут on 11/8/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillDescriptionViewController.h"

@interface RPGSkillDescriptionViewController ()

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
