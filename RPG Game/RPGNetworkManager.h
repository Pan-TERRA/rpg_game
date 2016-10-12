//
//  RPGNetworkManager.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//
  
#import <Foundation/Foundation.h>

/**
 *  Common network manager for HTTP requests. Provides authorization api, 
    static media download, auxiliary requests.
 */
@interface RPGNetworkManager : NSObject

+ (instancetype)sharedNetworkManager;

#pragma mark - API

#pragma mark - Authorization API

- (void)login;
- (void)logout;
- (void)registration;

#pragma mark - Quest API

- (void)fetchQuestByType:(int)aType;

@end
