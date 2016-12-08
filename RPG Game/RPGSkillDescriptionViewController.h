//
//  RPGSkillDescriptionViewController.h
//  RPG Game
//
//  Created by Владислав Крут on 11/8/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
  // Entities
@class RPGSkillRepresentation;

@interface RPGSkillDescriptionViewController : UIViewController

- (void)setViewContent:(RPGSkillRepresentation *)aSkillRepresentation;

@end
