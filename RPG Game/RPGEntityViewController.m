  //
  //  RPGEntityViewController.m
  //  RPG Game
  //
  //  Created by Иван Дзюбенко on 12/1/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGEntityViewController.h"
  // Controllers
#import "RPGBattleController+RPGBattlePresentationController.h"
  // Entities
#import "RPGPlayer.h"
  // Constants
#import "RPGNibNames.h"

static int sEntityViewContollerBattleEntityContext;

@interface RPGEntityViewController ()

@property (nonatomic, assign, readwrite) RPGBattleController *battleController;

@property (nonatomic, copy, readwrite) NSString *entityObservationKeyPath;

@property (nonatomic, assign, readwrite) IBOutlet UILabel *entityNickName;
@property (nonatomic, assign, readwrite) IBOutlet RPGProgressBarView *entityHPBar;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *entityHPLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIView *entityLevelView;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *entityLevelLabel;

@end

@implementation RPGEntityViewController

#pragma mark - Init

- (instancetype)initWithBattleController:(RPGBattleController *)aBattleController
                                   align:(RPGProgressBarAlign)anAlignFlag
{
  NSString *NIBName = nil;
  
  if (anAlignFlag)
  {
    NIBName = kRPGEntityViewLeftNIBName;
  }
  else
  {
    NIBName = kRPGEntityViewRightNIBName;
  }
  
  self = [super initWithNibName:NIBName bundle:nil];
  
  if (self != nil)
  {
    _battleController = aBattleController;
    _entityObservationKeyPath = nil;
  }
  
  return self;
}

#pragma mark - Dealloc


- (void)dealloc
{
  if (_entityObservationKeyPath != nil)
  {
    [_battleController removeObserver:self
                           forKeyPath:_entityObservationKeyPath
                              context:&sEntityViewContollerBattleEntityContext];
  }
  
  [_entityObservationKeyPath release];
  [super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  
    //  self.entityLevelView.layer.cornerRadius = kRPGBattleViewControllerLevelViewCornerRadius;
    //  self.entityLevelView.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Update

- (void)updateView
{
  RPGEntity *entity = [self valueForKeyPath:self.entityObservationKeyPath];
  
  if (entity != nil)
  {
    NSInteger entityHP = entity.HP;
    NSInteger entityMaxHP = entity.maxHP;
    entityHP = (entityHP <= entityMaxHP) ? entityHP : entityMaxHP;
    self.entityNickName.text = entity.name;
    self.entityHPBar.progress = ((float)entityHP / entityMaxHP);
    self.entityHPLabel.text = [NSString stringWithFormat:@"%ld/%ld", (long)entityHP, (long)entityMaxHP];
    self.entityLevelLabel.text = [NSString stringWithFormat:@"%ld", (long)entity.level];
  }
}

#pragma mark - Entity Observation Register

- (void)registerObservationEntityByKeyPath:(NSString *)aKeyPath
{
  self.entityObservationKeyPath = aKeyPath;
  
  [self addObserver:self
         forKeyPath:[NSString stringWithFormat:@"%@MasterProperty",aKeyPath]
            options:(NSKeyValueObservingOptionNew & NSKeyValueObservingOptionOld)
            context:&sEntityViewContollerBattleEntityContext];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)aKeyPath
                      ofObject:(id)anObject
                        change:(NSDictionary<NSString *,id> *)aChange
                       context:(void *)aContext
{
  if (aContext == &sEntityViewContollerBattleEntityContext)
  {
    [self updateView];
  }
  else
  {
    [super observeValueForKeyPath:aKeyPath ofObject:anObject change:aChange context:aContext];
  }
}

@end
