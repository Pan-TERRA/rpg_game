//
//  RPGQuestListViewController.h
//  RPG Game
//
//  Created by Максим Шульга on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
  // Constants
#import "RPGQuestListState.h"
#import "RPGQuestEnum.h"
  // Controllers
@class RPGQuestTableViewController;

@interface RPGQuestListViewController : UIViewController

@property (nonatomic, assign, readonly) IBOutlet UITableView *tableView;
@property (nonatomic, retain, readonly) RPGQuestTableViewController *tableViewController;


@property (nonatomic, assign, readwrite, getter=canSendRequest) BOOL sendRequest;

- (instancetype)initWithType:(RPGQuestType)aType;
- (void)setViewToWaitingForServerResponseState;
- (void)setViewToNormalState;
- (void)processQuestsData:(NSArray *)aData
                  byState:(RPGQuestListState)aState;

@end
