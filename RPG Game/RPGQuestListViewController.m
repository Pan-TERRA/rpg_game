//
//  RPGQuestListViewController.m
//  RPG Game
//
//  Created by Максим Шульга on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestListViewController.h"
#import "RPGQuestListTableViewCell.h"
#import "RPGQuestViewController.h"

static NSString *const kRPGMyQuestsViewControllerTableViewCellId = @"RPGQuestListTableViewCell";

@interface RPGQuestListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign, readwrite) IBOutlet UISegmentedControl *buttonControl;
@property (nonatomic, assign, readwrite) IBOutlet UITableView *tableView;

@end

@implementation RPGQuestListViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (IBAction)buttonControlOnClick:(UISegmentedControl *)sender
{
  [self.tableView reloadData];
  [self.tableView setContentOffset:CGPointZero animated:YES];
}

- (IBAction)backButtonOnClicked:(UIButton *)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSUInteger result = 0;
  return result;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  RPGQuestListTableViewCell *cell = (RPGQuestListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kRPGMyQuestsViewControllerTableViewCellId];
  
  if (cell == nil)
  {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:kRPGMyQuestsViewControllerTableViewCellId owner:self options:nil];
    cell = [nib objectAtIndex:0];
  }
  
  cell.titleLabel.text = @"Title";
  cell.descriptionLabel.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.";
//  cell.proofTypeImage.image = [[UIImage alloc] init];
//  cell.rewardTypeImage.image = [[UIImage alloc] init];
  
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self showQuestViewWithState:self.buttonControl.selectedSegmentIndex];
}

- (void)showQuestViewWithState:(RPGQuestListViewState)state
{
  RPGQuestViewController *questViewController = [[[RPGQuestViewController alloc] initWithNibName:NSStringFromClass([RPGQuestViewController class]) bundle:nil] autorelease];
  questViewController.state = state;
  [self presentViewController:questViewController animated:YES completion:nil];
}

- (void)dealloc
{
  [super dealloc];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
  return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (editingStyle == UITableViewCellEditingStyleDelete)
  {
    //delete here
    [tableView reloadData];
  }
}

@end