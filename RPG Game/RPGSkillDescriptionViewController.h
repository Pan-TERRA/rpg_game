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

@property (nonatomic, retain, readonly) RPGSkillRepresentation* skillRepresentation;

- (instancetype)initWithSkillRepresentation:(RPGSkillRepresentation *)aSkillRepresentation;

@end
