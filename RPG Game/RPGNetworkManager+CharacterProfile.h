//
//  RPGNetworkManager+CharacterProfile.h
//  RPG Game
//
//  Created by Максим Шульга on 11/17/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager.h"

@class RPGCharacterRequest;
@class RPGCharacterProfileInfoResponse;

@interface RPGNetworkManager (CharacterProfile)

- (void)getCharacterProfileInfoWithRequest:(RPGCharacterRequest *)aRequest
                         completionHandler:(void (^)(RPGCharacterProfileInfoResponse *))callbackBlock;

@end
