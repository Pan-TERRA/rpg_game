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
#import "RPGQuestEnum.h"
  // Entities
@class RPGQuest;

@protocol RPGQuestTableViewControllerDelegate <NSObject>

- (void)updateViewForState:(RPGQuestListState)aState
              shouldReload:(BOOL)aShouldReloadFlag;
- (void)setViewToNoQuestsState:(BOOL)aFlag;
- (void)showQuestViewWithQuest:(RPGQuest *)aQuest;
- (UIViewController *)getViewController;

@end

@interface RPGQuestTableViewController : NSObject

@property (nonatomic, assign, readwrite) id<RPGQuestTableViewControllerDelegate> delegate;
@property (nonatomic, assign, readwrite) RPGQuestListState questListState;
@property (nonatomic, assign, readwrite) RPGQuestType questType;

- (instancetype)initWithTableView:(UITableView *)aTableView;
- (void)setQuests:(NSArray<RPGQuest *> *)aQuests
forQuestListState:(RPGQuestListState)aState;

@end
