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

- (instancetype)initWithAlign:(RPGProgressBarAlign)anAlignFlag;

- (instancetype)initWithEntity:(RPGEntity *)anEntity
                         align:(RPGProgressBarAlign)anAlignFlag NS_DESIGNATED_INITIALIZER;

- (void)updateView;

@end
