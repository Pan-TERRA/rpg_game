//
//  RPGNetworkManager+Registration.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/18/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager.h"
  // Entities
@class RPGRegistrationRequest;

@interface RPGNetworkManager (Registration)

- (void)registerWithRequest:(RPGRegistrationRequest *)aRequest
          completionHandler:(void (^)(NSInteger))aCallback;

@end
