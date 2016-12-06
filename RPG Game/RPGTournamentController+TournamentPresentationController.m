//
//  RPGTournamentController+TournamentPresentationController.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/6/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGTournamentController+TournamentPresentationController.h"
  // Entities
#import "RPGBattle.h"
#import "RPGPlayer.h"

@implementation RPGTournamentController (TournamentPresentationController)

- (NSInteger)currentPlayerRank
{
  NSInteger currentWinCount = self.battle.player.currentWinCount;
  NSInteger result = -1;
  
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
    
      // not found - set max rank
    if (result == -1)
    {
      result = winsForRank.count;
    }
  }
  
  return result;
}

- (NSInteger)absoluteWinsForCurrentRank
{
  NSInteger currentPlayerRank = self.currentPlayerRank;
  NSInteger result = -1;
  
  if (currentPlayerRank != -1)
  {
    result = [self.winsForRanks[currentPlayerRank-1] integerValue];
  }
  
  return result;
}

- (NSInteger)absoluteWinsForNextRank
{
  NSInteger currentPlayerRank = self.currentPlayerRank;
  NSInteger result = -1;
  
  if (currentPlayerRank != -1)
  {
    result = [self.winsForRanks[currentPlayerRank] integerValue];
  }
  
  return result;
}

@end
