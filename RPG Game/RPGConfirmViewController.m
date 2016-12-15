//
//  RPGConfirmViewController.m
//  RPG Game
//
//  Created by Владислав Крут on 12/12/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGConfirmViewController.h"
  // Constants
#import "RPGNibNames.h"

@interface RPGConfirmViewController ()

@property (nonatomic, assign, readwrite) IBOutlet UILabel *questionLabel;

@end

@implementation RPGConfirmViewController

#pragma mark - Init

- (instancetype)init
{
  return [super initWithNibName:kRPGConfirmViewControllerNIBName bundle:nil];
}

- (instancetype)initWithQuestion:(NSString *)aQuestion completion:(void (^ _Nullable)())completionHandler
{
  self = [self init];
  
  if (self != nil)
  {
    if (completionHandler != nil)
    {
      _completionHandler = [completionHandler copy];
    }
    else
    {
      _completionHandler = [^void(void){} retain];
    }
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_completionHandler release];
  
  [_question release];
  [super dealloc];
}

#pragma mark - Custom Setter

- (void)setQuestion:(NSString *)aQuestion
{
  if (_question != aQuestion)
  {
    [_question release];
    _question = [aQuestion copy];
    self.questionLabel.text = aQuestion;
  }
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.questionLabel.text = self.question;
}

#pragma mark - Actions

- (IBAction)OKButtonOnClick:(UIButton *)sender
{
  if (self.completionHandler != nil)
  {
    dispatch_async(dispatch_get_main_queue(), ^
     {
       self.completionHandler();
     });
  }
  
  [self removeFromParentViewController];
  [self.view removeFromSuperview];
}

- (IBAction)cancelButtonOnClick:(UIButton *)sender
{
  [self removeFromParentViewController];
  [self.view removeFromSuperview];
}

@end
