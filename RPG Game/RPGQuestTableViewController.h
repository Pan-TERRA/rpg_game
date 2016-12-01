//
//  RPGQuestTableController.h
//  RPG Game
//
//  Created by Максим Шульга on 10/31/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
  // Constants
#import "RPGQuestListState.h"

@class RPGQuestListViewController;

@interface RPGQuestTableViewController : NSObject

@property (nonatomic, assign, readwrite) RPGQuestListState questListState;

- (instancetype)initWithTableView:(UITableView *)aTableView
             parentViewController:(RPGQuestListViewController *)aViewController;
- (void)deleteQuestWithID:(NSUInteger)anID;
- (void)setQuestArray:(NSArray *)aQuestArray
    forQuestListState:(RPGQuestListState)aState;
- (void)getRewardForQuestWithID:(NSUInteger)anID;

@end
