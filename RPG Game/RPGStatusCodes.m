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
    // Server Status Codes
  [kRPGStatusCodeOK] = @"OK",
  [kRPGStatusCodeWrongJSON] = @"Wrong JSON",
  [kRPGStatusCodeUserDoesNotExist] = @"User does not exist",
  [kRPGStatusCodeWrongEmail] = @"Wrong email",
  [kRPGStatusCodeWrongPassword] = @"Wrong password",
  [kRPGStatusCodeWrongToken] = @"Wrong token",
  [kRPGStatusCodeUsernameAlreadyTaken] = @"Username is already taken",
  [kRPGStatusCodeEmailAlreadyTaken] = @"Email is already taken",
  [kRPGStatusCodeQuestWithSuchIDNotFound] = @"Quest with such ID not found",
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
  [kRPGStatusCodeTurnAction] = @"Turn action",
  [kRPGStatusCodeWrongClass] = @"Wrong class",
  [kRPGStatusCodeClassNotFound] = @"Class not found",
  [kRPGStatusCodeBattleDoesNotExist] = @"Battle does not exist",
  [kRPGStatusCodeQuestNotAccepted] = @"Quest is not accepted",
  [kRPGStatusCodeQuestNotSkipped] = @"Quest is not skipped",
  [kRPGStatusCodeNoQuestForVoting] = @"No quest for voting",
  [kRPGStatusCodeClassesNotFound] = @"ClassesNotFound",
  [kRPGStatusCodeDefaultError] = @"Something went wrong",
  [kRPGStatusCodeEmptySkillsToSelect] = @"Empty skills",
  [kRPGStatusCodeHasNoSuchSkills] = @"Has no such skills",
  [kRPGStatusCodeHasNoAnySkills] = @"Has no such skills",
  [kRPGStatusCodeExceedActiveSkillsBagSize] = @"Exceed bag size",
  
    // RPGNetworkManager Status Codes
  [kRPGStatusCodeNetworkManagerUnknown] = @"Unknown network error",
  [kRPGStatusCodeNetworkManagerEmptyResponseData] = @"Response data is empty",
  [kRPGStatusCodeNetworkManagerServerError] = @"External server error",
  [kRPGStatusCodeNetworkManagerSerializingError] = @"Respose data serialization error",
  [kRPGStatusCodeNetworkManagerNoInternetConnection] = @"No Internet connection",
  [kRPGStatusCodeNetworkManagerResponseObjectValidationFail] = @"Response object validation failure"
};

NSString * const RPGStatusCodeTitle[] =
{
    // Server Status Codes
  [kRPGStatusCodeWrongJSON] = @"JSON Error",
  [kRPGStatusCodeUserDoesNotExist] = @"Error",
  [kRPGStatusCodeWrongEmail] = @"Error",
  [kRPGStatusCodeWrongPassword] = @"Error",
  [kRPGStatusCodeWrongToken] = @"Error",
  [kRPGStatusCodeUsernameAlreadyTaken] = @"Registration error",
  [kRPGStatusCodeEmailAlreadyTaken] = @"Registration error",
  [kRPGStatusCodeQuestWithSuchIDNotFound] = @"Quest error",
  [kRPGStatusCodeUserHasNoSuchCharacter] = @"Invalid character request",
  [kRPGStatusCodeSkillWithSuchIDNotFound] = @"Skills error",
  [kRPGStatusCodeNotYourTurn] = @"Battle error",
  [kRPGStatusCodeSkillOnCooldownOrDoesNotExist] = @"Skill error",
  [kRPGStatusCodeRunOutOfTime] = @"Battle error",
  [kRPGStatusCodeQuestAlreadyInProgress] = @"Quest error",
  [kRPGStatusCodeServerDidNotGetFile] = @"Server error",
  [kRPGStatusCodeUserHasNoSuchQuest] = @"Quest error",
  [kRPGStatusCodeNotPicture] = @"Server error",
  [kRPGStatusCodeTooBigPicture] = @"Server error",
  [kRPGStatusCodeTurnAction] = @"Error",
  [kRPGStatusCodeWrongClass] = @"Registration error",
  [kRPGStatusCodeClassNotFound] = @"Registration error",
  [kRPGStatusCodeBattleDoesNotExist] = @"Battle error",
  [kRPGStatusCodeQuestNotAccepted] = @"Quest error",
  [kRPGStatusCodeQuestNotSkipped] = @"Quest error",
  [kRPGStatusCodeNoQuestForVoting] = @"Quest error",
  [kRPGStatusCodeClassesNotFound] = @"Class error",
  [kRPGStatusCodeDefaultError] = @"Error",
  [kRPGStatusCodeEmptySkillsToSelect] = @"Character profile error",
  [kRPGStatusCodeHasNoSuchSkills] = @"Character profile error",
  [kRPGStatusCodeHasNoAnySkills] = @"Character profile error",
  [kRPGStatusCodeExceedActiveSkillsBagSize] = @"Character profile error",
  
    // RPGNetworkManager Status Codes
  [kRPGStatusCodeNetworkManagerUnknown] = @"Network error",
  [kRPGStatusCodeNetworkManagerEmptyResponseData] = @"Network error",
  [kRPGStatusCodeNetworkManagerServerError] = @"Network error",
  [kRPGStatusCodeNetworkManagerSerializingError] = @"Network error",
  [kRPGStatusCodeNetworkManagerNoInternetConnection] = @"Network error",
  [kRPGStatusCodeNetworkManagerResponseObjectValidationFail] = @"Network error"
};



NSString * const RPGStatusCodeActionTitle[] =
{
    // Server Status Codes
  [kRPGStatusCodeWrongJSON] = @"Go to login screen",
  [kRPGStatusCodeUserDoesNotExist] = @"OK",
  [kRPGStatusCodeWrongEmail] = @"OK",
  [kRPGStatusCodeWrongPassword] = @"OK",
  [kRPGStatusCodeWrongToken] = @"OK",
  [kRPGStatusCodeUsernameAlreadyTaken] = @"OK",
  [kRPGStatusCodeEmailAlreadyTaken] = @"OK",
  [kRPGStatusCodeQuestWithSuchIDNotFound] = @"OK",
  [kRPGStatusCodeUserHasNoSuchCharacter] = @"OK",
  [kRPGStatusCodeSkillWithSuchIDNotFound] = @"OK",
  [kRPGStatusCodeNotYourTurn] = @"OK",
  [kRPGStatusCodeSkillOnCooldownOrDoesNotExist] = @"OK",
  [kRPGStatusCodeRunOutOfTime] = @"OK",
  [kRPGStatusCodeQuestAlreadyInProgress] = @"OK",
  [kRPGStatusCodeServerDidNotGetFile] = @"OK",
  [kRPGStatusCodeUserHasNoSuchQuest] = @"OK",
  [kRPGStatusCodeNotPicture] = @"OK",
  [kRPGStatusCodeTooBigPicture] = @"OK",
  [kRPGStatusCodeTurnAction] = @"OK",
  [kRPGStatusCodeWrongClass] = @"OK",
  [kRPGStatusCodeClassNotFound] = @"OK",
  [kRPGStatusCodeBattleDoesNotExist] = @"OK",
  [kRPGStatusCodeQuestNotAccepted] = @"OK",
  [kRPGStatusCodeQuestNotSkipped] = @"OK",
  [kRPGStatusCodeNoQuestForVoting] = @"OK",
  [kRPGStatusCodeClassesNotFound] = @"OK",
  [kRPGStatusCodeDefaultError] = @"OK",
  
  [kRPGStatusCodeEmptySkillsToSelect] = @"OK",
  [kRPGStatusCodeHasNoSuchSkills] = @"OK",
  [kRPGStatusCodeHasNoAnySkills] = @"OK",
  [kRPGStatusCodeExceedActiveSkillsBagSize] = @"OK",
  
    // RPGNetworkManager Status Codes
  [kRPGStatusCodeNetworkManagerUnknown] = @"OK",
  [kRPGStatusCodeNetworkManagerEmptyResponseData] = @"OK",
  [kRPGStatusCodeNetworkManagerServerError] = @"OK",
  [kRPGStatusCodeNetworkManagerSerializingError] = @"OK",
  [kRPGStatusCodeNetworkManagerNoInternetConnection] = @"OK",
  [kRPGStatusCodeNetworkManagerResponseObjectValidationFail] = @"OK"
};
