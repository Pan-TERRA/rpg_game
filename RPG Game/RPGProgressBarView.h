//
//  RPGProgressBar.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/2/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
  // Constants
#import "RPGAlign.h"

IB_DESIGNABLE
@interface RPGProgressBarView : UIView

@property (nonatomic, assign, readwrite) IBInspectable int align; // int - IBInspectable support
@property (nonatomic, assign, readwrite) IBInspectable CGFloat progress;

@end
