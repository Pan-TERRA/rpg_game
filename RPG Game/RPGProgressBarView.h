//
//  RPGProgressBar.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/2/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(int, RPGProgressBarAlign)
{
    kRPGProgressBarRightAlign,
    kRPGProgressBarLeftAlign
};

IB_DESIGNABLE
@interface RPGProgressBarView : UIView

@property (nonatomic, assign, readwrite) IBInspectable int align;
@property (nonatomic, assign, readwrite) IBInspectable CGFloat progress;

@end
