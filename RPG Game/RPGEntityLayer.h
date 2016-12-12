//
//  RPGEntityLayer.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 12/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
  // Entities
@class RPGSpriteMap;

typedef NS_ENUM(NSUInteger, RPGEntityLayerState)
{
  kRPGEntityLayerStateIdle,
  kRPGEntityLayerStateAttack,
  kRPGEntityLayerStateDead,
  kRPGEntityLayerStateHurt
};

NS_ASSUME_NONNULL_BEGIN

@interface RPGEntityLayer : CALayer

@property (assign, readwrite, nonatomic) RPGEntityLayerState state;
@property (assign, readwrite, nonatomic) int frameIndex;
@property (assign, readonly, nonatomic) CGSize frameSize;

@property (retain, readonly, nonatomic, nonnull) RPGSpriteMap *spriteMap;

- (instancetype)initWithSpriteMap:(nonnull RPGSpriteMap *)aSpriteMap
                        frameSize:(CGSize)aFrameSize;

+ (instancetype)entityLayerWithSpriteMap:(nonnull RPGSpriteMap *)aSpriteMap
                               frameSize:(CGSize)aFrameSize;

@end

NS_ASSUME_NONNULL_END
