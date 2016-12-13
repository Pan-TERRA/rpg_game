//
//  RPGStatusCodes.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const RPGStatusCodeDescription[];
extern NSString * const RPGStatusCodeTitle[];
extern NSString * const RPGStatusCodeActionTitle[];

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
  kRPGStatusCodeClassNotFound = 21,
  kRPGStatusCodeBattleDoesNotExist = 22,
  kRPGStatusCodeQuestNotAccepted = 23,
  kRPGStatusCodeQuestNotSkipped = 24,
  kRPGStatusCodeNoQuestForVoting = 25,
  kRPGStatusCodeClassesNotFound = 26,
  kRPGStatusCodeEmptySkillsToSelect = 29,
  kRPGStatusCodeHasNoSuchSkills = 30,
  kRPGStatusCodeHasNoAnySkills = 31,
  kRPGStatusCodeExceedActiveSkillsBagSize = 33,
  kRPGStatusCodeCharacterLevelIsLesserThanSkills = 34,
  kRPGStatusCodeNotEnoughMoney = 35,
  kRPGStatusCodeWrongUnit = 36,
  kRPGStatusCodeUnitIsAlreadyBought = 37,
  kRPGStatusCodeInsufficientCrystalsAmount = 38,
  kRPGStatusCodeDifferentClassOfCharacterAndQuest = 39,
  kRPGStatusCodeLevelOfCharacterAndQuest = 40,
  kRPGStatusCodeTooShortUsername = 41,
  kRPGStatusCodeTooLongUsername = 42,
  kRPGStatusCodeTooShortPassword = 43,
  kRPGStatusCodeTooLongPassword = 44,
  kRPGStatusCodeTooShortCharacterName = 45,
  kRPGStatusCodeTooLongCharacterName = 46,
  kRPGStatusCodeInvalidUsername = 47,
  kRPGStatusCodeInvalidCharacterName = 48,
  kRPGStatusCodeUndefinedSymbolsInUsername = 49,
  kRPGStatusCodeUndefinedSymbolsInCharacterName = 50,
  kRPGStatusCodeWrongStageError = 63,
  kRPGStatusCodeStageIsNotEnabled = 64,
  
  kRPGStatusCodeDefaultError = 1337,
  
    // RPGNetworkManager Status Codes
  kRPGStatusCodeNetworkManagerUnknown = 1700,
  kRPGStatusCodeNetworkManagerEmptyResponseData = 1701,
  kRPGStatusCodeNetworkManagerServerError = 1702,
  kRPGStatusCodeNetworkManagerSerializingError = 1703,
  kRPGStatusCodeNetworkManagerNoInternetConnection = 1704,
  kRPGStatusCodeNetworkManagerResponseObjectValidationFail = 1705
};
