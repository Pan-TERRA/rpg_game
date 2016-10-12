//
//  RPGQuestListTableViewCell.h
//  RPG Game
//
//  Created by Максим Шульга on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPGQuestListTableViewCell : UITableViewCell

@property (nonatomic, assign, readwrite) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *proofTypeImage;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *rewardTypeImage;

@end