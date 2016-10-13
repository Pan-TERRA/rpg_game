//
//  RPGRegistrationViewController.m
//  RPG Game
//
//  Created by Степан Супинский on 10/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGRegistrationViewController.h"

@interface RPGRegistrationViewController ()

@property (nonatomic, retain) NSArray *classPickerData;
// Outlets
@property (assign, nonatomic) IBOutlet UILabel *errorLabel;

@property (assign, nonatomic) IBOutlet UITextField *usernameTextField;
@property (assign, nonatomic) IBOutlet UITextField *passwordTextField;
@property (assign, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (assign, nonatomic) IBOutlet UITextField *characterNameTextField;

@end

@implementation RPGRegistrationViewController

#pragma mark - Init/Dealloc

- (instancetype)init
{
  self = [super initWithNibName:@"RPGRegistrationViewController"
                         bundle:nil];
  if (self != nil)
  {
    _classPickerData = [[NSArray alloc] initWithObjects:@"Warrior", @"Mage", nil];
  }
  return self;
}

- (void)dealloc
{
  [_classPickerData release];
  [super dealloc];
}

#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - UIPickerView data source

// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
  return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
  return self.classPickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
  return self.classPickerData[row];
}

#pragma mark - Error representation

- (void)showErrorText:(NSString *)text
{
  self.errorLabel.text = text;
  [self.errorLabel setHidden:NO];
  [self.errorLabel sizeToFit];
}

#pragma mark - Actions

- (IBAction)submitButtonAction:(UIButton *)sender
{
  if (![self.passwordTextField.text isEqualToString:self.confirmPasswordTextField.text])
  {
    [self showErrorText:@"Password doesn't match. Lorem ipsum if the message is too large."];
  }
}

@end
