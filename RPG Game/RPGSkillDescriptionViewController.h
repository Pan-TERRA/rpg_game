//
//  RPGSkillDescriptionViewController.h
//  RPG Game
//
//  Created by Владислав Крут on 11/8/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RPGSkillRepresentation;

@interface RPGSkillDescriptionViewController : UIViewController

- (instancetype)initWithSkillRepresentation:(RPGSkillRepresentation *)aSkillRepresentation;
+ (instancetype)viewControllerWithSkillRepresentation:(RPGSkillRepresentation *)aSkillRepresentation;

@end
