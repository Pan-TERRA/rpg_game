//
//  RPGSkillsEffectsViewController.m
//  RPG Game
//
//  Created by Максим Шульга on 12/5/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillsEffectsViewController.h"

#import "RPGBattleController.h"
#import "RPGBattle.h"
  // Views
#import "RPGCharacterBagCollectionViewCell.h"
  // Constants
#import "RPGNibNames.h"

static int sRPGSkillsEffectsViewControllerSkillsEffects;
static NSInteger kRPGSkillsEffectsViewControllerCollectionSize = 6;

@interface RPGSkillsEffectsViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (retain, nonatomic, readwrite) RPGBattleController *battleController;
@property (retain, nonatomic) IBOutlet UICollectionView *skillsEffectsCollectionView;

@end

@implementation RPGSkillsEffectsViewController

- (instancetype)init
{
  return [super initWithNibName:kRPGSkillsEffectsViewControllerNIBName bundle:nil];
}

- (instancetype)initWithBattleController:(RPGBattleController *)aBattleController
{
  self = [super initWithNibName:kRPGSkillsEffectsViewControllerNIBName bundle:nil];
  
  if (self != nil)
  {
    _battleController = [aBattleController retain];
    [_battleController addObserver:self
                        forKeyPath:@"battle.playerSkillsEffects"
                           options:(NSKeyValueObservingOptionNew)
                           context:&sRPGSkillsEffectsViewControllerSkillsEffects];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_battleController removeObserver:self
                         forKeyPath:@"battle.playerSkillsEffects"
                            context:&sRPGSkillsEffectsViewControllerSkillsEffects];
  [_battleController release];
  
  [_skillsEffectsCollectionView release];
  [super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UINib *cellNIB = [UINib nibWithNibName:kRPGCharacterBagCollectionViewCellNIBName bundle:nil];
  [self.skillsEffectsCollectionView registerNib:cellNIB forCellWithReuseIdentifier:kRPGCharacterBagCollectionViewCellNIBName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return kRPGSkillsEffectsViewControllerCollectionSize;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)aCollectionView cellForItemAtIndexPath:(NSIndexPath *)anIndexPath
{
  RPGCharacterBagCollectionViewCell *cell = [aCollectionView dequeueReusableCellWithReuseIdentifier:kRPGCharacterBagCollectionViewCellNIBName
                                                                                       forIndexPath:anIndexPath];
  
//  NSInteger index = anIndexPath.row;
//  NSArray *skillsEffects = self.battleController.battle;
//  if (index < self.collectionSize)
//  {
//    if (index < self.skillsIDArray.count)
//    {
//      NSUInteger skillID = [self.skillsIDArray[index] integerValue];
//      RPGSkillRepresentation *skillRepresentation = [RPGSkillRepresentation skillrepresentationWithSkillID:skillID];
//      
//      if (skillRepresentation.imageName.length != 0)
//      {
//        cell.image = [UIImage imageNamed:@"battle_empty_icon_inactive"];
//        cell.backgroundImageView.image = [UIImage imageNamed:skillRepresentation.imageName];
//        cell.backgroundImageView.layer.cornerRadius = kRPGCollectionViewControllerSkillButtonCornerRadius;
//        cell.backgroundImageView.layer.masksToBounds = YES;
//      }
//      else
//      {
//        // default image for skills/items with no image
//        cell.image = [UIImage imageNamed:@"battle_empty_icon_unset"];
//        cell.backgroundImageView.image = nil;
//      }
//    }
//    else
//    {
//      // unset skills or empty bag cells
//      [cell setImage:[UIImage imageNamed:@"battle_empty_icon_inactive"]];
//      cell.backgroundImageView.image = nil;
//    }
//  }
//  else
//  {
//    // locked bag cells/skills
//    [cell setImage:[UIImage imageNamed:@"battle_empty_icon_lock"]];
//    cell.backgroundImageView.image = nil;
//  }
//  
  return cell;
}




#pragma mark - Notifications

- (void)observeValueForKeyPath:(NSString *)aKeyPath
                      ofObject:(id)anObject
                        change:(NSDictionary<NSString *, id> *)aChange
                       context:(void *)aContext
{
  if (aContext == &sRPGSkillsEffectsViewControllerSkillsEffects)
  {
    if ([aChange[NSKeyValueChangeKindKey] unsignedIntegerValue] == NSKeyValueChangeInsertion)
    {
      NSIndexSet *newObjectIndices = aChange[NSKeyValueChangeIndexesKey];
//      RPGBattleAction *battleAction = self.battleController.actions[newObjectIndices.firstIndex];
//      [self addMessageWithAction:battleAction];
//      [self playSkillSFXWithAction:battleAction];
//      [self scrollViewToBottom];
    }
  }
  else
  {
    [super observeValueForKeyPath:aKeyPath
                         ofObject:anObject
                           change:aChange
                          context:aContext];
  }
}

@end
