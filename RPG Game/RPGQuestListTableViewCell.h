//
//  RPGQuestListTableViewCell.h
//  RPG Game
//
//  Created by Максим Шульга on 12/14/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
  // Constants
#import "RPGQuestAction.h"
#import "RPGQuestListState.h"
#import "RPGQuestEnum.h"

@protocol RPGQuestTableViewCellDelegate <NSObject>

- (void)getRewardForQuestWithID:(NSInteger)aQuestID;
- (void)doQuestAction:(RPGQuestAction)anAction
               byType:(RPGQuestType)aType
              questID:(NSInteger)aQuestID
             friendID:(NSInteger)aFriendID;

@end

@interface RPGQuestListTableViewCell : UITableViewCell

@property (nonatomic, assign, readwrite) id<RPGQuestTableViewCellDelegate> delegate;

- (void)setCellContent:(id)aCellContent;

@end
