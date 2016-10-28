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
    // Server Status Codes
  kRPGStatusCodeOk,
  kRPGStatusCodeWrongJSON,
  kRPGStatusCodeUserDoesNotExist,
  kRPGStatusCodeWrongEmail,
  kRPGStatusCodeWrongPassword,
  kRPGStatusCodeWrongToken,
  kRPGStatusCodeUsernameIsAlreadyTaken,
  kRPGStatusCodeEmailIsAlreadyTaken,
  kRPGStatusCodeAlreadyOnline,
  kRPGStatusCodeUserHasNoSuchCharacter,
  kRPGStatusCodeSkillWithSuchIDNotFound,
  kRPGStatusCodeNotYourTurn,
  kRPGStatusCodeSkillOnCooldownOrDoesNotExist,
  kRPGStatusCodeRunOutOfTime,
  kRPGStatusCodeQuestAlreadyInProgress,
  kRPGStatusCodeServerDidNotGetFile,
  kRPGStatusCodeUserHasNoSuchQuest,
  kRPGStatusCodeNotPicture,
  kRPGStatusCodeTooBigPicture,
  kRPGStatusCodeTurnAction,
  
    // RPGNetworkManager Status Codes
  kRPGStatusCodeNetworkManagerUnknown = 1700,
  kRPGStatusCodeNetworkManagerEmptyResponseData = 1701,
  kRPGStatusCodeNetworkManagerServerError = 1702,
  kRPGStatusCodeNetworkManagerSerializingError = 1703,
  kRPGStatusCodeNetworkManagerNoInternetConnection = 1704,
  kRPGStatusCodeNetworkManagerResponseObjectValidationFail = 1705
};
