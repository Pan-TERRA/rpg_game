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

@property (nonatomic, copy, readonly) NSString *proofImageStringURL1;
@property (nonatomic, copy, readonly) NSString *proofImageStringURL2;
@property (nonatomic, assign, readwrite) RPGQuestState state;
@property (nonatomic, assign, readonly) RPGQuestType questType;
@property (nonatomic, assign, readonly) NSInteger questID;
@property (nonatomic, assign, readonly) NSInteger duelQuestFriendID;
@property (nonatomic, assign, readonly, getter=hasGotReward) BOOL getReward;
@property (nonatomic, retain, readonly) UIImagePickerController *imagePickerController;
@property (nonatomic, assign, readwrite, getter=didMadeProof) BOOL makeProof;

- (void)setViewContent:(RPGQuest *)aQuest;

@end
