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
  [kRPGStatusCodeWrongPassword] = @"Wrong password",
  [kRPGStatusCodeWrongToken] = @"Wrong token",
  [kRPGStatusCodeUsernameIsAlreadyTaken] = @"Username is already taken",
  [kRPGStatusCodeEmailIsAlreadyTaken] = @"Email is already taken"
};