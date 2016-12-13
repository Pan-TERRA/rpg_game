//
//  RPGTournamentController+RPGTournamentPresentationController.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/6/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleController+RPGTournamentPresentationController.h"
  // Entities
#import "RPGBattle.h"
#import "RPGPlayer.h"
  // Constants
#import "RPGResourceNames.h"

@implementation RPGBattleController (RPGTournamentPresentationController)

- (NSArray *)winsForRanks
{
  NSString *ranksPlistPath = [[NSBundle mainBundle] pathForResource:kRPGRanksPlistName
                                                             ofType:@"plist"];
  return [[[NSArray alloc] initWithContentsOfFile:ranksPlistPath] autorelease];
}

- (NSInteger)playerCurrentWinCount
{
  return self.battle.player.currentWinCount;
}

- (NSInteger)currentPlayerRank
{
  NSInteger result = -1;
  NSInteger currentWinCount = self.battle.player.currentWinCount;
  
  if (currentWinCount != -1)
  {
    NSArray *winsForRank = self.winsForRanks;
    
      // find rank by winCount
    for (NSInteger rank = 0; rank < winsForRank.count; rank++)
    {
      if (currentWinCount >= [winsForRank[rank] integerValue])
      {
        result = rank + 1;
        break;
      }
    }
  }
  
  return result;
}

- (NSInteger)absoluteWinsForCurrentRank
{
  NSInteger result = -1;
  NSInteger currentPlayerRank = self.currentPlayerRank;
  
  if (currentPlayerRank != -1)
  {
    result = [self.winsForRanks[currentPlayerRank - 1] integerValue];
  }
  
  return result;
}

- (NSInteger)absoluteWinsForNextRank
{
  NSInteger result = -1;
  NSInteger currentPlayerRank = self.currentPlayerRank;
  
  if (currentPlayerRank != -1)
  {
    result = [self.winsForRanks[currentPlayerRank - 2] integerValue];
  }
  
  return result;
}

@end
