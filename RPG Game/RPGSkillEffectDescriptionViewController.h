//
//  RPGSkillEffectDescriptionViewController.h
//  RPG Game
//
//  Created by Максим Шульга on 12/9/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
  // Entities
@class RPGSkillEffectRepresentation;

@interface RPGSkillEffectDescriptionViewController : UIViewController

- (void)setViewContent:(RPGSkillEffectRepresentation *)aSkillEffectRepresentation;

@end
