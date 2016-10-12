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

@property (nonatomic, retain, readwrite) NSMutableArray *takeQuestsMutableArray;
@property (nonatomic, retain, readwrite) NSMutableArray *inProgressQuestsMutableArray;
@property (nonatomic, retain, readwrite) NSMutableArray *doneQuestsMutableArray;

@end

@implementation RPGQuestListViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.takeQuestsMutableArray = [[NSMutableArray alloc] init];
  self.inProgressQuestsMutableArray = [[NSMutableArray alloc] init];
  self.doneQuestsMutableArray = [[NSMutableArray alloc] init];
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
  RPGQuestListViewState state = sender.selectedSegmentIndex;
  switch (state)
  {
    case kRPGQuestListViewTakeQuest:
      //upload from server self.takeQuestsMutableArray
      break;
    case kRPGQuestListViewInProgressQuest:
      //upload from server self.inProgressQuestsMutableArray
      break;
    case kRPGQuestListViewDoneQuest:
      //upload from server self.doneQuestsMutableArray
      break;
    case kRPGQuestListViewCheckQuest:
      [self showQuestViewWithState:state];
      break;
  }
  if (state != kRPGQuestListViewCheckQuest)
  {
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointZero animated:YES];
  }
}

- (IBAction)backButtonOnClicked:(UIButton *)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSUInteger result = 0;
  switch (self.buttonControl.selectedSegmentIndex)
  {
    case kRPGQuestListViewTakeQuest:
      result = [self.takeQuestsMutableArray count];
      break;
    case kRPGQuestListViewInProgressQuest:
      result = [self.inProgressQuestsMutableArray count];
      break;
    case kRPGQuestListViewDoneQuest:
      result = [self.doneQuestsMutableArray count];
      break;
  }
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
  [self.takeQuestsMutableArray release];
  [self.inProgressQuestsMutableArray release];
  [self.doneQuestsMutableArray release];
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
    switch (self.buttonControl.selectedSegmentIndex)
    {
      case kRPGQuestListViewTakeQuest:
        [self.takeQuestsMutableArray removeObjectAtIndex:indexPath.row];
        break;
      case kRPGQuestListViewInProgressQuest:
        [self.inProgressQuestsMutableArray removeObjectAtIndex:indexPath.row];
        break;
      case kRPGQuestListViewDoneQuest:
        [self.doneQuestsMutableArray removeObjectAtIndex:indexPath.row];
        break;
    }
    [tableView reloadData];
  }
}

@end