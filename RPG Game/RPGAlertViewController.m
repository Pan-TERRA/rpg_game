//
//  RPGAlert.m
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
            completionHandler:(void (^)(void))aCompletionHandler
{
  self = [super initWithNibName:kRPGAlertViewControllerNIBName bundle:nil];
  
  if (self != nil)
  {
    _alertTitleLabelText = [aTitle copy];
    _alertDescriptionLabelText = [aTitle copy];
    _alertActionButtonText = [aTitle copy];
    _completionHandler = Block_copy(aCompletionHandler);
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithTitle:kRPGAlertViewControllerDefaultTitle
                 description:kRPGAlertViewControllerDefaultDescription
           completionHandler:nil];
}

#pragma mark - I

- (void)dealloc
{
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
  self.alertActionButton.titleLabel.text = self.alertActionButtonText;
}

#pragma mark - IBAction

- (IBAction)alertButtonAction:(UIButton *)sender
{
  
}

@end
