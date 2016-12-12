  //
  //  RPGBattleAnimationViewController.m
  //  RPG Game
  //
  //  Created by Иван Дзюбенко on 12/10/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGBattleAnimationViewController.h"
  // Views
#import "RPGEntityLayer.h"
  // Entities
#import "RPGSpriteMap.h"

@interface RPGBattleAnimationViewController ()

@property (retain, readwrite, nonatomic) RPGEntityLayer *entityLayer;

@end

@implementation RPGBattleAnimationViewController


- (instancetype)init
{
  return [super initWithNibName:@"RPGBattleAnimationViewController"
                         bundle:nil];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  RPGSpriteMap *spriteMap = [[RPGSpriteMap new] autorelease];
  CGSize mainSpriteMapFrameSize = CGSizeMake(587.0, 707.0);
  CGSize deadSpriteMapFrameSize = CGSizeMake(944.0, 751.0);

  CGRect (^animationControllerFunction)(int, CGRect) = ^CGRect(int frameIndex, CGRect contentsRect)
  {
   CGRect result = CGRectZero;
   
   if (NSLocationInRange(frameIndex, NSMakeRange(0, 5)))
   {
     result = CGRectMake(contentsRect.size.width * frameIndex, 0, contentsRect.size.width, contentsRect.size.height);
   }
   else if (NSLocationInRange(frameIndex, NSMakeRange(5, 10)))
   {
     result = CGRectMake(contentsRect.size.width * (frameIndex - 5), contentsRect.size.height, contentsRect.size.width, contentsRect.size.height);
   }
   
   return result;
 };
  
  CGRect (^deadAnimationControllerFunction)(int, CGRect) = ^CGRect(int frameIndex, CGRect contentsRect)
  {
    CGRect result = CGRectZero;
    
    if (frameIndex == 0 || frameIndex == 1)
    {
      result = CGRectMake(contentsRect.size.width * frameIndex, 0, contentsRect.size.width, contentsRect.size.height);
    }
    else if (frameIndex == 2 || frameIndex == 3)
    {
      result = CGRectMake(contentsRect.size.width * (frameIndex - 2), contentsRect.size.height, contentsRect.size.width, contentsRect.size.height);
    }
    else if (frameIndex == 4 || frameIndex == 5)
    {
      result = CGRectMake(contentsRect.size.width * (frameIndex - 4), contentsRect.size.height * 2, contentsRect.size.width, contentsRect.size.height);
    }
    else if (frameIndex == 6 || frameIndex == 7)
    {
      result = CGRectMake(contentsRect.size.width * (frameIndex - 6), contentsRect.size.height * 3, contentsRect.size.width, contentsRect.size.height);
    }
    else if (frameIndex == 8 || frameIndex == 9)
    {
      result = CGRectMake(contentsRect.size.width * (frameIndex - 8), contentsRect.size.height * 4, contentsRect.size.width, contentsRect.size.height);
    }
    
    return result;
  };
  
  spriteMap.idleSpriteMapImage = [UIImage imageNamed:@"knight_idle_spritemap"];
  spriteMap.idleAnimationControlFunction = animationControllerFunction;
  spriteMap.idleSpriteMapFrame = mainSpriteMapFrameSize;
  
  spriteMap.attackSpriteMapImage = [UIImage imageNamed:@"knight_attack_spritemap"];
  spriteMap.attackAnimationControlFunction = animationControllerFunction;
  spriteMap.attackSpriteMapFrame = mainSpriteMapFrameSize;
  
  spriteMap.deadSpriteMapImage = [UIImage imageNamed:@"knight_dead_spritemap"];
  spriteMap.deadAnimationControlFunction = deadAnimationControllerFunction;
  spriteMap.deadSpriteMapFrame = deadSpriteMapFrameSize;
  
  self.entityLayer = [RPGEntityLayer entityLayerWithSpriteMap:spriteMap frameSize:CGSizeMake(147, 177)];
  self.entityLayer.delegate = self.entityLayer;

  [self.view.layer addSublayer:self.entityLayer];
  [self.entityLayer setNeedsDisplay];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)firstAnimationAction:(UIButton *)sender
{
  self.entityLayer.state = 0;
}

- (IBAction)secondAnimationAction:(UIButton *)sender
{
  self.entityLayer.state = 1;
}

- (IBAction)thirdAnimationAction:(UIButton *)sender
{
  self.entityLayer.state = 2;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
