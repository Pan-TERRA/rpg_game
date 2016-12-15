//
//  RPGButtonQuestViewController.h
//  RPG Game
//
//  Created by Максим Шульга on 12/15/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
  // Views
@class RPGQuestViewController;

@interface RPGButtonQuestViewController : UIViewController

- (instancetype)initWithQuestViewController:(RPGQuestViewController *)aViewController;
- (void)updateView;

@end
