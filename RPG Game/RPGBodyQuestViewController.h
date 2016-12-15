//
//  RPGBodyQuestViewController.h
//  RPG Game
//
//  Created by Максим Шульга on 12/15/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
// Views
@class RPGQuestViewController;
// Entities
@class RPGQuest;

@interface RPGBodyQuestViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, retain, readonly) UIImageView *proofImageView1;
@property (nonatomic, assign, readonly) UIImageView *proofImageView2;

- (instancetype)initWithQuestViewController:(RPGQuestViewController *)aViewController;
- (void)setViewContent:(RPGQuest *)aQuest;
- (void)updateView;
- (void)downloadImage:(NSString *)aStringURL
            imageView:(UIImageView *)anImageView;

@end
