//
//  UIColor+RPGColorEquality.m
//  RPG Game
//
//  Created by Степан Супинский on 12/3/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "UIColor+RPGColorEquality.h"

@implementation UIColor (RPGColorEquality)

- (BOOL)isEqualToColor:(UIColor *)anOtherColor
{
  BOOL result = NO;
  CGFloat tolerance = 0.0001;
  
  const CGFloat *selfComponents = CGColorGetComponents(self.CGColor);
  const CGFloat *otherColorComponents = CGColorGetComponents(anOtherColor.CGColor);
  
  if (fabs(selfComponents[0] - otherColorComponents[0]) <= tolerance
      && fabs(selfComponents[1] - otherColorComponents[1]) <= tolerance
      && fabs(selfComponents[2] - otherColorComponents[2]) <= tolerance
      && fabs(selfComponents[3] - otherColorComponents[3]) <= tolerance)
  {
    result = YES;
  }
  
  return result;
}

@end
