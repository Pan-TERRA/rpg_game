//
//  RPGQuestViewBodyContainer.h
//  RPG Game
//
//  Created by Максим Шульга on 11/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
  // Views
@class RPGQuestViewController;
  // Entities
@class RPGQuest;

@interface RPGQuestViewBodyContainer : UIScrollView <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, assign, readwrite) RPGQuestViewController *questViewController;
@property (nonatomic, retain, readonly) UIImageView *proofImageView1;
@property (nonatomic, assign, readonly) UIImageView *proofImageView2;

- (void)setViewContent:(RPGQuest *)aQuest;
- (void)updateView;
- (void)downloadImage:(NSString *)aStringURL
            imageView:(UIImageView *)anImageView;

@end
