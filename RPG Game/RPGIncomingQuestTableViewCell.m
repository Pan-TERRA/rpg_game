//
//  RPGIncomingQuestListTableViewCell.m
//  RPG Game
//
//  Created by Максим Шульга on 12/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGIncomingQuestTableViewCell.h"
  // Entities
#import "RPGIncomingDuelQuest.h"

@interface RPGIncomingQuestTableViewCell ()

@property (nonatomic, assign, readwrite) IBOutlet UILabel *friendUsernameLabel;
@property (nonatomic, assign, readwrite) NSInteger friendID;
@property (nonatomic, assign, readwrite) NSInteger questID;

@end

@implementation RPGIncomingQuestTableViewCell

#pragma mark - Cell Content

- (void)setCellContent:(RPGIncomingDuelQuest *)aCellContent
{
  self.friendUsernameLabel.text = aCellContent.friendUsername;
  self.friendID = aCellContent.friendID;
  self.questID = aCellContent.questID;
}

#pragma mark - IBAction

- (IBAction)acceptButtonOnClick:(UIButton *)sender
{
  [self.delegate doQuestAction:kRPGQuestActionTakeQuest
                        byType:kRPGQuestTypeDuel
                       questID:self.questID
                      friendID:self.friendID];
}

- (IBAction)denyButtonOnClick:(UIButton *)sender
{
  [self.delegate doQuestAction:kRPGQuestActionDeleteQuest
                        byType:kRPGQuestTypeDuel
                       questID:self.questID
                      friendID:self.friendID];
}

@end
