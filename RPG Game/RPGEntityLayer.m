  //
  //  RPGEntityLayer.m
  //  RPG Game
  //
  //  Created by Иван Дзюбенко on 12/10/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "UIKit/UIKit.h"
#import "RPGEntityLayer.h"
  // Entities
#import "RPGSpriteMap.h"

@interface RPGEntityLayer ()

@property (assign, readwrite, nonatomic) CGSize normalizedFrameSize;
@property (assign, readwrite, nonatomic) CGSize frameSize;

@end

@implementation RPGEntityLayer

#pragma mark - Init

- (instancetype)initWithSpriteMap:(RPGSpriteMap *)aSpriteMap frameSize:(CGSize)aFrameSize
{
  self = [super init];
  
  if (self != nil)
  {
    _frameIndex = 0;
    _state = kRPGEntityLayerStateIdle;
    _spriteMap = [aSpriteMap retain];
    _frameSize = aFrameSize;
    
    CGImageRef spriteMapImageRef = _spriteMap.idleSpriteMapImage.CGImage;
    CGSize spriteMapFrameSize = _spriteMap.idleSpriteMapFrame;
    
    self.contents = (id)(spriteMapImageRef);
    CGRect baseRect = CGRectMake(0, 0, _frameSize.width, _frameSize.height);
    self.bounds = baseRect;
    self.frame = baseRect;
    
    _normalizedFrameSize = CGSizeMake(spriteMapFrameSize.width/CGImageGetWidth(spriteMapImageRef),
                                      spriteMapFrameSize.height/CGImageGetHeight(spriteMapImageRef));
    self.contentsRect = CGRectMake(0, 0, _normalizedFrameSize.width, _normalizedFrameSize.height);
  }
  
  return self;
}

- (instancetype)initWithLayer:(id)layer
{
  self = [super initWithLayer:layer];

  if (self != nil)
  {
    _frameIndex = ((RPGEntityLayer *)layer).frameIndex;
  }

  return self;
}

+ (instancetype)entityLayerWithSpriteMap:(RPGSpriteMap *)aSpriteMap frameSize:(CGSize)aFrameSize
{
  return [[[self alloc] initWithSpriteMap:aSpriteMap frameSize:aFrameSize] autorelease];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_spriteMap release];
  
  [super dealloc];
}

#pragma mark - State Machine

- (void)setState:(RPGEntityLayerState)aState
{
    // TODO: Add validation
  _state = aState;
  
  switch (_state)
  {
    case kRPGEntityLayerStateIdle:
    {
      [self idleAnimation];
      break;
    }
      
    case kRPGEntityLayerStateAttack:
    {
      [self attackAnimation];
      break;
    }
      
    case kRPGEntityLayerStateHurt:
    {
      [self hurtAnimation];
      break;
    }
      
    case kRPGEntityLayerStateDead:
    {
      [self deadAnimation];
      break;
    }
      
    default:
    {
      [self idleAnimation];
      break;
    }
  }
}

+ (BOOL)needsDisplayForKey:(NSString *)key;
{
  if ([key isEqualToString:@"frameIndex"])
  {
    return YES;
  }
  
  return [super needsDisplayForKey:key];
}

+ (id <CAAction>)defaultActionForKey:(NSString *)aKey;
{
  if ([aKey isEqualToString:@"contentsRect"])
    return (id <CAAction>)[NSNull null];
  
  if ([aKey isEqualToString:@"contents"])
    return (id <CAAction>)[NSNull null];
  
  return [super defaultActionForKey:aKey];
}

- (void)display
{
  int currentFrameIndex = ((RPGEntityLayer*)[self presentationLayer]).frameIndex;
  CGRect currentContentsRect = ((RPGEntityLayer*)[self presentationLayer]).contentsRect;
  
  CGRect newContentsRect = CGRectZero;
  
  if (self.state == kRPGEntityLayerStateDead)
  {
    newContentsRect = self.spriteMap.deadAnimationControlFunction(currentFrameIndex, currentContentsRect);
  }
  else
  {
    newContentsRect = self.spriteMap.idleAnimationControlFunction(currentFrameIndex, currentContentsRect);
  }
  
  self.contentsRect = newContentsRect;
}

#pragma mark - Animation

  // TODO: remove repetitions
- (void)idleAnimation
{
  [self removeAllAnimations];
  
  self.contents = (id)self.spriteMap.idleSpriteMapImage.CGImage;
  [self normalizeContentsRectangleWithSpriteMapFrameSize:self.spriteMap.idleSpriteMapFrame];
  
  CABasicAnimation *idleAnimation = [CABasicAnimation animationWithKeyPath:@"frameIndex"];
  idleAnimation.fromValue = [NSNumber numberWithInt:0];
  idleAnimation.toValue = [NSNumber numberWithInt:9];
  
  idleAnimation.duration = 0.9f;
  idleAnimation.repeatCount = HUGE_VALF;
  
  [self addAnimation:idleAnimation forKey:nil];
}

- (void)attackAnimation
{
  [self removeAllAnimations];
  
  self.contents = (id)self.spriteMap.attackSpriteMapImage.CGImage;
  [self normalizeContentsRectangleWithSpriteMapFrameSize:self.spriteMap.attackSpriteMapFrame];
  
  CABasicAnimation *attackAnimation = [CABasicAnimation animationWithKeyPath:@"frameIndex"];
  
  attackAnimation.fromValue = [NSNumber numberWithInt:0];
  attackAnimation.toValue = [NSNumber numberWithInt:9];
  
  attackAnimation.duration = 1.0f;
  attackAnimation.repeatCount = 1;
  
  [self addAnimation:attackAnimation forKey:nil];
  
  self.frameIndex = 0;
}

- (void)deadAnimation
{
  [self removeAllAnimations];
  
  self.contents = (id)self.spriteMap.deadSpriteMapImage.CGImage;
  [self normalizeContentsRectangleWithSpriteMapFrameSize:self.spriteMap.deadSpriteMapFrame];
  
  CABasicAnimation *deadAnimation = [CABasicAnimation animationWithKeyPath:@"frameIndex"];
  
  
  deadAnimation.fromValue = @(0);
  deadAnimation.toValue = @(9);
  
  deadAnimation.duration = 1.0f;
  deadAnimation.repeatCount = 0.0;
  
  [self addAnimation:deadAnimation forKey:nil];
  
  self.frameIndex = 9;
}

- (void)normalizeContentsRectangleWithSpriteMapFrameSize:(CGSize)aFrameSize
{
  self.normalizedFrameSize = CGSizeMake(aFrameSize.width/CGImageGetWidth((CGImageRef)self.contents),
                                        aFrameSize.height/CGImageGetHeight((CGImageRef)self.contents));
  self.contentsRect = CGRectMake(0, 0, self.normalizedFrameSize.width, self.normalizedFrameSize.height);
}

@end
