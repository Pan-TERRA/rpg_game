  //
  //  RPGEntityViewController.h
  //  RPG Game
  //
  //  Created by Иван Дзюбенко on 12/1/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import <UIKit/UIKit.h>
  // Entity
@class RPGEntity;
  // Views
#import "RPGProgressBarView.h"

@interface RPGEntityViewController : UIViewController

@property (nonatomic, assign, readwrite) RPGEntity *entity;

- (instancetype)initWithAlign:(RPGAlign)anAlign;

- (instancetype)initWithEntity:(RPGEntity *)anEntity
                         align:(RPGAlign)anAlign NS_DESIGNATED_INITIALIZER;

- (void)updateView;

@end
