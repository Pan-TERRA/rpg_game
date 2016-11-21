//
//  RPGAlertController+RPGErrorHandling.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAlertController+RPGErrorHandling.h"
  // Constants
#import "RPGStatusCodes.h"

@implementation RPGAlertController (RPGErrorHandling)

#pragma mark - Helper Method

+ (void)showErrorWithStatusCode:(RPGStatusCode)aStatusCode
{
	 [RPGAlertController showAlertWithTitle:RPGStatusCodeTitle[aStatusCode]
                                  message:RPGStatusCodeDescription[aStatusCode]
                               completion:nil];
}

#pragma mark - General Client-Server Errors

+ (void)handleWrongJSON
{
  [self showErrorWithStatusCode:kRPGStatusCodeWrongJSON];
}

+ (void)handleUserDoesNotExist
{
  [self showErrorWithStatusCode:kRPGStatusCodeUserDoesNotExist];
}

+ (void)handleWrongEmail
{
  [self showErrorWithStatusCode:kRPGStatusCodeWrongEmail];
}

+ (void)handleWrongPassword
{
  [self showErrorWithStatusCode:kRPGStatusCodeWrongPassword];
}

+ (void)handleWrongToken
{
  [self showErrorWithStatusCode:kRPGStatusCodeWrongToken];
}

+ (void)handleUsernameAlreadyTaken
{
  [self showErrorWithStatusCode:kRPGStatusCodeUsernameAlreadyTaken];
}

+ (void)handleEmailAlreadyTaken
{
  [self showErrorWithStatusCode:kRPGStatusCodeUsernameAlreadyTaken];
}

#pragma mark Quests

+ (void)handleQuestWithSuchIDNotFound
{
  [self showErrorWithStatusCode:kRPGStatusCodeQuestWithSuchIDNotFound];
}

+ (void)handleQuestAlreadyInProgress
{
  [self showErrorWithStatusCode:kRPGStatusCodeQuestAlreadyInProgress];
}

+ (void)handleServerDidNotGetFile
{
  [self showErrorWithStatusCode:kRPGStatusCodeServerDidNotGetFile];
}

+ (void)handleUserHasNoSuchQuest
{
  [self showErrorWithStatusCode:kRPGStatusCodeUserHasNoSuchQuest];
}

+ (void)handleNotPicture
{
  [self showErrorWithStatusCode:kRPGStatusCodeNotPicture];
}

+ (void)handleTooBigPicture
{
  [self showErrorWithStatusCode:kRPGStatusCodeTooBigPicture];
}

+ (void)handleTurnAction
{
  [self showErrorWithStatusCode:kRPGStatusCodeTurnAction];
}

+ (void)handleQuestNotAccepted
{
  [self showErrorWithStatusCode:kRPGStatusCodeQuestNotAccepted];
}

+ (void)handleQuestNotSkipped
{
  [self showErrorWithStatusCode:kRPGStatusCodeQuestNotSkipped];
}

+ (void)handleNoQuestForVoting
{
  [self showErrorWithStatusCode:kRPGStatusCodeNoQuestForVoting];
}

#pragma mark Character

+ (void)handleUserHasNoSuchCharacter
{
  [self showErrorWithStatusCode:kRPGStatusCodeUserHasNoSuchCharacter];
}

#pragma mark Skills

+ (void)handleSkillWithSuchIDNotFound
{
  [self showErrorWithStatusCode:kRPGStatusCodeSkillWithSuchIDNotFound];
}

#pragma mark Battle

+ (void)handleNotYourTurn
{
  [self showErrorWithStatusCode:kRPGStatusCodeNotYourTurn];
}

+ (void)handleSkillOnCooldownOrDoesNotExist
{
  [self showErrorWithStatusCode:kRPGStatusCodeSkillOnCooldownOrDoesNotExist];
}

+ (void)handleRunOutOfTime
{
  [self showErrorWithStatusCode:kRPGStatusCodeRunOutOfTime];
}

+ (void)handleBattleDoesNotExist
{
  [self showErrorWithStatusCode:kRPGStatusCodeBattleDoesNotExist];
}

#pragma mark Class

+ (void)handleWrongClass
{
  [self showErrorWithStatusCode:kRPGStatusCodeWrongClass];
}

+ (void)handleClassNotFound
{
  [self showErrorWithStatusCode:kRPGStatusCodeClassNotFound];
}

+ (void)handleClassesNotFound
{
  [self showErrorWithStatusCode:kRPGStatusCodeClassesNotFound];
}

#pragma mark - Network Manager Errors

+ (void)handleNoInternetConnection
{
  [self showErrorWithStatusCode:kRPGStatusCodeNetworkManagerNoInternetConnection];
}

#pragma mark - Default

+ (void)handleDefaultError
{
  [self showErrorWithStatusCode:kRPGStatusCodeDefaultError];
}




@end
