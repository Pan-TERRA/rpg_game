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
@property (nonatomic, copy, nullable) void (^completionHandler)(void);

@end

@implementation RPGWaitingViewController

#pragma mark - Init

- (instancetype)init
{
  return [super initWithNibName:kRPGWaitingViewControllerNIBName bundle:nil];
}

- (instancetype)initWithMessage:(NSString *)aMessage completion:(void (^ _Nullable)())completionHandler
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
    _message = [aMessage copy];
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

#pragma mark - UICollectionView

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  self.messageLabel.text = self.message;
}

#pragma mark - Actions

- (IBAction)back:(UIButton *)sender
{
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
  {
     _completionHandler();
  });
  
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
