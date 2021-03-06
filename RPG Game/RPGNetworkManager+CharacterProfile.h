//
//  RPGNetworkManager+CharacterProfile.h
//  RPG Game
//
//  Created by Максим Шульга on 11/17/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager.h"
  // Constants
#import "RPGStatusCodes.h"
  // Entities
@class RPGCharacterRequest;
@class RPGCharacterProfileInfoResponse;
@class RPGCharacterAvatarSelectRequest;

@interface RPGNetworkManager (CharacterProfile)

- (void)getCharacterProfileInfoWithRequest:(RPGCharacterRequest *)aRequest
                         completionHandler:(void (^)(RPGStatusCode aNetworkStatusCode,
                                                     RPGCharacterProfileInfoResponse *aResponse))aCallback;
- (void)characterAvatarSelectWithRequest:(RPGCharacterAvatarSelectRequest *)aRequest
                       completionHandler:(void (^)(RPGStatusCode aNetworkStatusCode))aCallback;

@end
