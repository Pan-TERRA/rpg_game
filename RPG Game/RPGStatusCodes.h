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
  kRPGStatusCodeOK = 0,
  kRPGStatusCodeWrongJSON = 1,
  kRPGStatusCodeUserDoesNotExist = 2,
  kRPGStatusCodeWrongEmail = 3,
  kRPGStatusCodeWrongPassword = 4,
  kRPGStatusCodeWrongToken = 5,
  kRPGStatusCodeUsernameAlreadyTaken = 6,
  kRPGStatusCodeEmailAlreadyTaken = 7,
  kRPGStatusCodeQuestWithSuchIDNotFound = 8,
  kRPGStatusCodeUserHasNoSuchCharacter = 9,
  kRPGStatusCodeSkillWithSuchIDNotFound = 10,
  kRPGStatusCodeNotYourTurn = 11,
  kRPGStatusCodeSkillOnCooldownOrDoesNotExist = 12,
  kRPGStatusCodeRunOutOfTime = 13,
  kRPGStatusCodeQuestAlreadyInProgress = 14,
  kRPGStatusCodeServerDidNotGetFile = 15,
  kRPGStatusCodeUserHasNoSuchQuest = 16,
  kRPGStatusCodeNotPicture = 17,
  kRPGStatusCodeTooBigPicture = 18,
  kRPGStatusCodeTurnAction = 19,
  kRPGStatusCodeWrongClass = 20,
  kRPGStatusCodeQuestNotAccepted = 21,
  kRPGStatusCodeQuestNotSkipped = 22,
  
    // RPGNetworkManager Status Codes
  kRPGStatusCodeNetworkManagerUnknown = 1700,
  kRPGStatusCodeNetworkManagerEmptyResponseData = 1701,
  kRPGStatusCodeNetworkManagerServerError = 1702,
  kRPGStatusCodeNetworkManagerSerializingError = 1703,
  kRPGStatusCodeNetworkManagerNoInternetConnection = 1704,
  kRPGStatusCodeNetworkManagerResponseObjectValidationFail = 1705
};
