//
//  RPGNetworkManager.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//
//
//#pragma clang diagnostic ignored "-Wnullability-completeness"

  
#import <Foundation/Foundation.h>
  // Constants
#import "RPGStatusCodes.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API constants

  // General
extern NSString * const kRPGNetworkManagerAPIHost;
extern NSString * const kRPGNetworkManagerAPITokenExistsRoute;
  // Resources
extern NSString * const kRPGNetworkManagerAPIResourcesRoute;
  // Authorization
extern NSString * const kRPGNetworkManagerAPILoginRoute;
extern NSString * const kRPGNetworkManagerAPISignoutRoute;
  // Registration
extern NSString * const kRPGNetworkManagerAPIRegisterRoute;
  // Quests
extern NSString * const kRPGNetworkManagerAPIQuestsRoute;
extern NSString * const kRPGNetworkManagerAPIQuestsInProgressRoute;
extern NSString * const kRPGNetworkManagerAPIConfirmedQuestsRoute;
extern NSString * const kRPGNetworkManagerAPIReviewQuestsRoute;
extern NSString * const kRPGNetworkManagerAPIAcceptQuestRoute;
extern NSString * const kRPGNetworkManagerAPISkipQuestRoute;
extern NSString * const kRPGNetworkManagerAPIReviewResultQuestRoute;
extern NSString * const kRPGNetworkManagerAPIProofQuestRoute;
extern NSString * const kRPGNetworkManagerAPIGetQuestRewardRoute;
  // Quest Challenge
extern NSString * const kRPGNetworkManagerAPISendQuestChallengeRoute;
  // Skills
extern NSString * const kRPGNetworkManagerAPISkillsRoute;
extern NSString * const kRPGNetworkManagerAPISkillInfoRoute;
  // Classes
extern NSString * const kRPGNetworkManagerAPIClassesRoute;
extern NSString * const kRPGNetworkManagerAPIClassInfoRoute;
  // Character Profile
extern NSString * const kRPGNetworkManagerAPICharacterProfileInfoRoute;
extern NSString * const kRPGNetworkManagerAPISelectSkillsRoute;
extern NSString * const kRPGNetworkManagerAPICharacterAvatarSelectRoute;
  // Friends
extern NSString * const kRPGNetworkManagerAPIFriendsRoute;
extern NSString * const kRPGNetworkManagerAPIAddFriendRoute;
extern NSString * const kRPGNetworkManagerAPICancelFriendRequestRoute;
extern NSString * const kRPGNetworkManagerAPIDeleteFriendRoute;
extern NSString * const kRPGNetworkManagerAPIAcceptFriendRequestRoute;
extern NSString * const kRPGNetworkManagerAPISkipFriendRequestRoute;
  // Constants
extern NSString * const kRPGRequestToken;
extern NSString * const kRPGNetworkManagerStatus;
  // Shop
extern NSString * const kRPGNetworkManagerAPIShopUnitsRoute;
extern NSString * const kRPGNetworkManagerAPIShopBuyUnitRoute;
  // Arena
extern NSString * const kRPGNetworkManagerAPIArenaSkillsRoute;
extern NSString * const kRPGNetworkManagerAPIArenaPayRoute;
  // Adventures
extern NSString * const kRPGNetworkManagerAPIAdventuresLocationsRoute;
extern NSString * const kRPGNetworkManagerAPIAdventuresLocationInfoRoute;

  // Entities
@class RPGResourcesResponse;

#pragma mark -

/**
 *  Common network manager for HTTP requests. Provides authorization api,
 static media download, auxiliary requests.
 */
@interface RPGNetworkManager : NSObject

+ (instancetype)sharedNetworkManager;

#pragma mark - Helper Methods

/**
 *  Helper method. Returns request with specific URL and HTTP method, body is JSON
 *  presentation of an object. Raises exception if serialization fails.
 *
 *  @param anObject Serializable object or NSDictionary instance
 *  @param aMethod  HTTP method
 *
 *  @return
 */
- (NSURLRequest *)requestWithObject:(nullable id)anObject
                          URLstring:(NSString *)aString
                             method:(NSString *)aMethod
                  shouldInjectToken:(BOOL)anInjectTokenFlag;

  // Invokes requestWithObject:URLstring:method:shouldInjectToken: with anInjectTokenFlag = YES
- (NSURLRequest *)requestWithObject:(nullable id)anObject
                          URLstring:(NSString *)aString
                             method:(NSString *)aMethod;

#pragma mark - Error Handling

- (BOOL)isNoInternerConnection:(NSError *)anError;
- (BOOL)isResponseCodeNot200:(NSURLResponse *)aResponse;

#pragma mark - General Requests

- (void)requestIfCurrentTokenIsValidWithCompletionHandler:(void (^)(BOOL anIsValidFlag))aCallback;
- (void)getResourcesWithCompletionHandler:(void (^)(RPGStatusCode aNetworkStatusCode,
                                                    RPGResourcesResponse *aResponse))aCallback;
- (void)getImageDataFromPath:(NSString *)aPath
           completionHandler:(void (^)(RPGStatusCode aNetworkStatusCode,
                                       NSData *anImageData))aCallback;

@end

NS_ASSUME_NONNULL_END
