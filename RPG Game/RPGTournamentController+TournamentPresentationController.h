//
//  RPGTournamentController+TournamentPresentationController.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/6/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGTournamentController.h"

@interface RPGTournamentController (TournamentPresentationController)

@property (assign, nonatomic, readonly) NSInteger currentPlayerRank;
@property (assign, nonatomic, readonly) NSInteger absoluteWinsForCurrentRank;
@property (assign, nonatomic, readonly) NSInteger absoluteWinsForNextRank;

@end
