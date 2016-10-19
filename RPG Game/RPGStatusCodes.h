//
//  RPGStatusCodes.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const RPGStatusCodeDescription[];

typedef NS_ENUM(NSInteger, RPGStatusCode)
{
  kRPGStatusCodeOk,
  kRPGStatusCodeWrongJSON,
  kRPGStatusCodeUserDoesNotExist,
  kRPGStatusCodeWrongPassword,
  kRPGStatusCodeWrongToken,
  kRPGStatusCodeUsernameIsAlreadyTaken,
  kRPGStatusCodeEmailIsAlreadyTaken
};
