//
//  RPGQuestListTableViewCell.h
//  RPG Game
//
//  Created by Максим Шульга on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RPGQuest;
@class RPGQuestTableViewController;

@protocol RPGTableViewCellDelegate <NSObject>

- (void)deleteQuestWithID:(NSUInteger)aQuestID;
- (void)getRewardForQuestWithID:(NSUInteger)aQuestID;

@end

@interface RPGQuestListTableViewCell : UITableViewCell

@property (nonatomic, assign, readwrite) id<RPGTableViewCellDelegate> delegate;

- (void)setCellContent:(RPGQuest *)aCellContent;

@end
