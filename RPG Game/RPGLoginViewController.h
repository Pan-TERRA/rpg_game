//
//  RPGLoginViewController.h
//  RPG Game
//
//  Created by Степан Супинский on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPGViewController.h"

@interface RPGLoginViewController : RPGViewController

- (void)loginActionWithEmail:(NSString *)anEmail password:(NSString *)aPassword;

@end
