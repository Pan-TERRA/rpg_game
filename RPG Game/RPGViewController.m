  //
  //  RPGViewController.m
  //  RPG Game
  //
  //  Created by Иван Дзюбенко on 11/17/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGViewController.h"

static CGFloat const kRPGViewControllerContentInsetsGap = 10.0;

@implementation RPGViewController

#pragma mark - Init

- (instancetype)initWithNibName:(NSString *)aNibNameOrNil
                         bundle:(NSBundle *)aNibBundleOrNil
{
  self = [super initWithNibName:aNibNameOrNil
                         bundle:aNibBundleOrNil];
  
  if (self != nil)
  {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(keyboardWillShow:)
                          name:UIKeyboardWillShowNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(keyboardWillHide:)
                          name:UIKeyboardWillHideNotification
                        object:nil];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  
  [super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

#pragma mark - Keyboard Notifications

- (void)keyboardWillShow:(NSNotification *)aNotification
{
  CGRect keyboardFrame = [aNotification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
  CGFloat adjustmentHeight = keyboardFrame.size.height + kRPGViewControllerContentInsetsGap;
  UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, adjustmentHeight, 0.0);
  self.scrollView.contentInset = contentInsets;
  self.scrollView.scrollIndicatorInsets = contentInsets;
  
    // Shrink view
  CGRect viewRect = self.view.frame;
  viewRect.size.height -= keyboardFrame.size.height;
    // Check if input text field is not visible
  if (!CGRectContainsPoint(viewRect, self.activeField.frame.origin))
  {
    [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
  }
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
  UIEdgeInsets contentInsets = UIEdgeInsetsZero;
  self.scrollView.contentInset = contentInsets;
  self.scrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark - UITextFieldDelegate

- (IBAction)userDoneEnteringText:(UITextField *)aSender
{
  
}

- (IBAction)userTappedView:(UITapGestureRecognizer *)aSender
{
  [self.activeField endEditing:YES];
}

  // First responder toggle
- (void)textFieldDidBeginEditing:(UITextField *)aTextField
{
  self.activeField = aTextField;
}

- (void)textFieldDidEndEditing:(UITextField *)aTextField
{
  self.activeField = nil;
}

@end
