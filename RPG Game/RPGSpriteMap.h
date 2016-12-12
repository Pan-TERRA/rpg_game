  //
  //  RPGSpriteMap.h
  //  RPG Game
  //
  //  Created by Иван Дзюбенко on 12/11/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import <UIKit/UIKit.h>

typedef CGRect (^controlerFunction)(int, CGRect);

@interface RPGSpriteMap : NSObject

@property (assign, readwrite, nonatomic) CGSize idleSpriteMapFrame;
@property (assign, readwrite, nonatomic) CGSize attackSpriteMapFrame;
@property (assign, readwrite, nonatomic) CGSize hurtSpriteMapFrame;
@property (assign, readwrite, nonatomic) CGSize deadSpriteMapFrame;

@property (retain, readwrite, nonatomic) UIImage *idleSpriteMapImage;
@property (retain, readwrite, nonatomic) UIImage *attackSpriteMapImage;
@property (retain, readwrite, nonatomic) UIImage *hurtSpriteMapImage;
@property (retain, readwrite, nonatomic) UIImage *deadSpriteMapImage;

@property (copy, readwrite, nonatomic) controlerFunction idleAnimationControlFunction;
@property (copy, readwrite, nonatomic) controlerFunction attackAnimationControlFunction;
@property (copy, readwrite, nonatomic) controlerFunction hurtAnimationControlFunction;
@property (copy, readwrite, nonatomic) controlerFunction deadAnimationControlFunction;

@end
