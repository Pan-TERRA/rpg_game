//
//  RPGProgressBar.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/2/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGProgressBar.h"
#import <QuartzCore/QuartzCore.h>

@interface RPGProgressBar ()

@end

@implementation RPGProgressBar

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  
  if (self != nil)
  {
    _progress = 1.0;
    _align = kRPGProgressBarRightAlign;
  }
  
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  
  if (self != nil)
  {
    _progress = 1.0;
    _align = kRPGProgressBarRightAlign;
  }
  return self;
}

#pragma mark - Accessors

- (void)setProgress:(CGFloat)aProgress
{
  if (_progress != aProgress)
  {
    if (aProgress > 1)
    {
      _progress = 1;
    }
    else if (aProgress < 0)
    {
      _progress = 0;
    }
    else
    {
        _progress = aProgress;
      
        CGFloat originX = self.frame.origin.x;
        CGFloat originY = self.frame.origin.y;
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        CGFloat currentWidth = self.frame.size.width * _progress;
        CGRect currentProgressBarRect = CGRectZero;
        
        if (self.align == kRPGProgressBarRightAlign)
        {
          currentProgressBarRect = CGRectMake(originX, originY, currentWidth, height);
        }
        else
        {
          currentProgressBarRect = CGRectMake(originX + width - currentWidth, originY, currentWidth, height);
        }
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelay:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        
        self.frame = currentProgressBarRect;
        
        [UIView commitAnimations];
    }
  }
}

#pragma mark - Draw Rect

- (void)drawRect:(CGRect)rect
{
  [super drawRect:rect];
  
  UIImage *progressBarImage = [UIImage imageNamed:@"pink_bar"];
  [progressBarImage drawInRect:rect];
}

@end
