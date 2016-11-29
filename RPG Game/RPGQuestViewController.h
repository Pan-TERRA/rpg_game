//
//  RPGQuestViewController.h
//  RPG Game
//
//  Created by Максим Шульга on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPGQuest.h"

extern NSString * const kRPGQuestViewControllerWaitingMessageDownload;
extern NSString * const kRPGQuestViewControllerWaitingMessageUpload;

@interface RPGQuestViewController : UIViewController

@property (nonatomic, copy, readonly) NSString *proofImageStringURL;
@property (nonatomic, assign, readwrite) RPGQuestState state;
@property (nonatomic, assign, readonly) NSUInteger questID;
@property (nonatomic, assign, readonly, getter=hasGotReward) BOOL getReward;
@property (nonatomic, retain, readonly) UIImagePickerController *imagePickerController;

- (void)setViewContent:(RPGQuest *)aQuest;

@end
