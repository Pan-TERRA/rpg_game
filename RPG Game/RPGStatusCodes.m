//
//  RPGStatusCodes.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGStatusCodes.h"

NSString * const RPGStatusCodeDescription[] =
{
  [kRPGStatusCodeOk] = @"OK",
  [kRPGStatusCodeWrongJSON] = @"Wrong JSON",
  [kRPGStatusCodeUserDoesNotExist] = @"User does not exist",
  [kRPGStatusCodeWrongEmail] = @"Wrong email",
  [kRPGStatusCodeWrongPassword] = @"Wrong password",
  [kRPGStatusCodeWrongToken] = @"Wrong token",
  [kRPGStatusCodeUsernameIsAlreadyTaken] = @"Username is already taken",
  [kRPGStatusCodeEmailIsAlreadyTaken] = @"Email is already taken",
  [kRPGStatusCodeAlreadyOnline] = @"Already online",
  [kRPGStatusCodeUserHasNoSuchCharacter] = @"User has no such character",
  [kRPGStatusCodeSkillWithSuchIDNotFound] = @"Skill with such ID not found",
  [kRPGStatusCodeNotYourTurn] = @"Not your turn",
  [kRPGStatusCodeSkillOnCooldownOrDoesNotExist] = @"Skill is on cooldown or does not exist",
  [kRPGStatusCodeRunOutOfTime] = @"Run out of time",
  [kRPGStatusCodeQuestAlreadyInProgress] = @"Quest is already in progress",
  [kRPGStatusCodeServerDidNotGetFile] = @"Server did not get file",
  [kRPGStatusCodeUserHasNoSuchQuest] = @"User has no such quest",
  [kRPGStatusCodeNotPicture] = @"Not a picture",
  [kRPGStatusCodeTooBigPicture] = @"Too big picture",
  [kRPGStatusCodeTurnAction] = @"Turn action"
};
