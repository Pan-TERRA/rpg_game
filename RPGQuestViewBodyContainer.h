//
//  RPGQuestViewBodyContainer.h
//  RPG Game
//
//  Created by Максим Шульга on 11/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RPGQuestViewController;
@class RPGQuest;

@interface RPGQuestViewBodyContainer : UIScrollView <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, assign, readwrite) RPGQuestViewController *questViewController;

- (void)setViewContent:(RPGQuest *)aQuest;
- (void)updateView;
- (void)downloadImage;

@end
