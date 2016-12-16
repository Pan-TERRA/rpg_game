 //
//  RPGWaitingViewController.m
//  RPG Game
//
//  Created by Максим Шульга on 11/18/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGWaitingViewController.h"
  // Constants
#import "RPGNibNames.h"

@interface RPGWaitingViewController ()

@property (nonatomic, assign, readwrite) IBOutlet UILabel *messageLabel;

@end

@implementation RPGWaitingViewController

#pragma mark - Init

- (instancetype)init
{
  return [self initWithMessage:@""];
}

- (instancetype)initWithMessage:(NSString *)aMessage
{
  return [self initWithMessage:aMessage completion:nil];
}

- (instancetype)initWithMessage:(NSString *)aMessage completion:(void (^ _Nullable)())completionHandler
{
  self = [super initWithNibName:kRPGWaitingViewControllerNIBName bundle:nil];
  
  if (self != nil)
  {
    _message = [aMessage copy];
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
  [_message release];
  
  [super dealloc];
}

#pragma mark - Custom Setter

- (void)setMessage:(NSString *)aMessage
{
  if (_message != aMessage)
  {
    [_message release];
    _message = [aMessage retain];
    self.messageLabel.text = _message;
  }
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.messageLabel.text = self.message;
}

#pragma mark - Actions

- (IBAction)back:(UIButton *)sender
{
  if (self.completionHandler != nil)
  {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
      _completionHandler();
    });
  }
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
