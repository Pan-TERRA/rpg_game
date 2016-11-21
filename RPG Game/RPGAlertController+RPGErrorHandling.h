//
//  RPGAlertController+RPGErrorHandling.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAlertController.h"

@interface RPGAlertController (RPGErrorHandling)

#pragma mark - General Client-Server Errors

+ (void)handleWrongJSON;
+ (void)handleUserDoesNotExist;
+ (void)handleWrongEmail;
+ (void)handleWrongPassword;
+ (void)handleWrongToken;
+ (void)handleUsernameAlreadyTaken;
+ (void)handleEmailAlreadyTaken;

#pragma mark Quests

+ (void)handleQuestWithSuchIDNotFound;
+ (void)handleQuestAlreadyInProgress;
+ (void)handleServerDidNotGetFile;
+ (void)handleUserHasNoSuchQuest;
+ (void)handleNotPicture;
+ (void)handleTooBigPicture;
+ (void)handleTurnAction;
+ (void)handleQuestNotAccepted;
+ (void)handleQuestNotSkipped;
+ (void)handleNoQuestForVoting;

#pragma mark Character

+ (void)handleUserHasNoSuchCharacter;

#pragma mark Skills

+ (void)handleSkillWithSuchIDNotFound;

#pragma mark Battle

+ (void)handleNotYourTurn;
+ (void)handleSkillOnCooldownOrDoesNotExist;
+ (void)handleRunOutOfTime;
+ (void)handleBattleDoesNotExist;

#pragma mark Class

+ (void)handleWrongClass;
+ (void)handleClassNotFound;
+ (void)handleClassesNotFound;

#pragma mark - Network Manager Errors

+ (void)handleNoInternetConnection;

#pragma mark - Default

+ (void)handleDefaultError;

@end
