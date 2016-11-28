  //
  //  RPGAlertViewController.m
  //  RPG Game
  //
  //  Created by Максим Шульга on 11/1/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGAlertViewController.h"
  // Constants
#import "RPGNibNames.h"

static NSString * const kRPGAlertViewControllerDefaultTitle = @"Alert Title";
static NSString * const kRPGAlertViewControllerDefaultDescription = @"Alert Title";
static NSString * const kRPGAlertViewControllerDefaultActionTitle = @"Alert Action";

@interface RPGAlertViewController ()

@property (assign, nonatomic) IBOutlet UILabel *alertTitleLabel;
@property (copy, nonatomic)  NSString *alertTitleLabelText;

@property (assign, nonatomic) IBOutlet UILabel *alertDescriptionLabel;
@property (copy, nonatomic)  NSString *alertDescriptionLabelText;

@property (assign, nonatomic) IBOutlet UIButton *alertActionButton;
@property (copy, nonatomic)  NSString *alertActionButtonText;

@property (nonatomic, copy, nullable) void (^completionHandler)(void);

@end

@implementation RPGAlertViewController

#pragma mark - Init

- (instancetype)initWithTitle:(NSString *)aTitle
                  description:(NSString *)aDescription
                  actionTitle:(NSString *)anActionTitle
            completionHandler:(void (^ __nullable)(void))aCompletionHandler
{
  self = [super initWithNibName:kRPGAlertViewControllerNIBName bundle:nil];
  
  if (self != nil)
  {
    _alertTitleLabelText = [aTitle copy];
    _alertDescriptionLabelText = [aDescription copy];
    _alertActionButtonText = [anActionTitle copy];
    
    if (aCompletionHandler != nil)
    {
      _completionHandler = [aCompletionHandler copy];
    }
    else
    {
        // empty block
      _completionHandler = [^void(void){} retain];
    }
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithTitle:kRPGAlertViewControllerDefaultTitle
                 description:kRPGAlertViewControllerDefaultDescription
                 actionTitle:kRPGAlertViewControllerDefaultActionTitle
           completionHandler:nil];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_completionHandler release];
  [_alertTitleLabelText release];
  [_alertDescriptionLabelText release];
  [_alertActionButtonText release];
  [super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.alertTitleLabel.text = self.alertTitleLabelText;
  self.alertDescriptionLabel.text = self.alertDescriptionLabelText;
  [self.alertActionButton setTitle:self.alertActionButtonText forState:UIControlStateNormal];
}

#pragma mark - IBActions

- (IBAction)alertButtonAction:(UIButton *)sender
{
  if (_completionHandler != nil)
  {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
      _completionHandler();
    });
  }
  
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
