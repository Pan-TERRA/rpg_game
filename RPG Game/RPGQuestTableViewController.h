//
//  RPGQuestTableController.h
//  RPG Game
//
//  Created by Максим Шульга on 10/31/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RPGQuestListState.h"

@class RPGQuestListViewController;

@interface RPGQuestTableViewController : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign, readwrite) RPGQuestListViewController *questListViewController;
@property (nonatomic, retain, readwrite) NSMutableArray *takeQuestsMutableArray;
@property (nonatomic, retain, readwrite) NSMutableArray *inProgressQuestsMutableArray;
@property (nonatomic, retain, readwrite) NSMutableArray *doneQuestsMutableArray;
@property (nonatomic, assign, readwrite) RPGQuestListState questListState;

@end
