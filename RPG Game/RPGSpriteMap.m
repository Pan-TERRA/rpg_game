  //
  //  RPGSpriteMap.m
  //  RPG Game
  //
  //  Created by Иван Дзюбенко on 12/11/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGSpriteMap.h"

@interface RPGSpriteMap ()

@property (assign, readwrite, nonatomic) CGSize frameSize;
@property (assign, readwrite, nonatomic) CGSize spriteMapFrameSize;

@end

@implementation RPGSpriteMap

#pragma mark - Dealloc

- (void)dealloc
{
  [_idleAnimationControlFunction release];
  [_attackAnimationControlFunction release];
  [_hurtAnimationControlFunction release];
  [_deadAnimationControlFunction release];
  
  [_idleSpriteMapImage release];
  [_attackSpriteMapImage release];
  [_hurtSpriteMapImage release];
  [_deadSpriteMapImage release];
  
  [super dealloc];
}

@end
