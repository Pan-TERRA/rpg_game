//
//  RPGQuestListViewController.h
//  RPG Game
//
//  Created by Максим Шульга on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RPGQuestListViewState)
{
  kRPGQuestListViewTakeQuest,
  kRPGQuestListViewInProgressQuest,
  kRPGQuestListViewDoneQuest,
  kRPGQuestListViewCheckQuest
};

@interface RPGQuestListViewController : UIViewController

@end