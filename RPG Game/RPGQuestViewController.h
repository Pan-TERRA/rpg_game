//
//  RPGQuestViewController.h
//  RPG Game
//
//  Created by Максим Шульга on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPGQuest.h"

@interface RPGQuestViewController : UIViewController

@property (nonatomic, copy, readonly) NSString *proofImageStringURL;
@property (nonatomic, assign, readwrite) RPGQuestState state;
@property (nonatomic, assign, readonly) NSUInteger questID;
@property (nonatomic, retain, readonly) UIImagePickerController *imagePickerController;

- (void)setViewContent:(RPGQuest *)aQuest;

@end
