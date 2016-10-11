//
//  RPGQuestViewController.h
//  RPG Game
//
//  Created by Максим Шульга on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPGQuestListViewController.h"

@interface RPGQuestViewController : UIViewController

@property (nonatomic, assign, readwrite) RPGQuestListViewState state;

@end