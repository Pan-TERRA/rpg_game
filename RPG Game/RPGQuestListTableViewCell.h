//
//  RPGQuestListTableViewCell.h
//  RPG Game
//
//  Created by Максим Шульга on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RPGQuest;

@interface RPGQuestListTableViewCell : UITableViewCell

- (void)setCellContent:(RPGQuest *)aCellContent;

@end
