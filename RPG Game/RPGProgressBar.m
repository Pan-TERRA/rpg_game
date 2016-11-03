//
//  RPGProgressBar.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/2/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGProgressBar.h"

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
  }
}

#pragma mark - Draw Rect

- (void)drawRect:(CGRect)rect
{
  [super drawRect:rect];
  
  CGFloat width = rect.size.width;
  CGFloat currentWidth = rect.size.width * self.progress;
  CGFloat height = rect.size.height;
  CGRect progressBarRect = CGRectZero;
  
  if (self.align == kRPGProgressBarRightAlign)
  {
    progressBarRect = CGRectMake(0, 0, currentWidth, height);
  }
  else
  {
    progressBarRect = CGRectMake(width - currentWidth, 0, currentWidth, height);
  }
  
  
  UIImage *progressImage = [UIImage imageNamed:@"pink_bar"];
  [progressImage drawInRect:progressBarRect];
}

@end
