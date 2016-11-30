//
//  RPGRegistrationRequest.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 10/14/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGSerializable.h"

@interface RPGRegistrationRequest : NSObject <RPGSerializable>

@property (nonatomic, copy, readonly) NSString *username;
@property (nonatomic, copy, readonly) NSString *email;
@property (nonatomic, copy, readonly) NSString *password;
@property (nonatomic, copy, readonly) NSString *characterName;
@property (nonatomic, assign, readonly) NSInteger characterType;
@property (nonatomic, assign, readonly) NSInteger avatarID;

- (instancetype)initWithEmail:(NSString *)anEmail
                     password:(NSString *)aPassword
                     username:(NSString *)aUsername
                characterName:(NSString *)aCharacterName
                characterType:(NSInteger)aCharacterType
                     avatarID:(NSInteger)anAvatarID NS_DESIGNATED_INITIALIZER;
+ (instancetype)registrationRequestWithEmail:(NSString *)anEmail
                                    password:(NSString *)aPassword
                                    username:(NSString *)aUsername
                               characterName:(NSString *)aCharacterName
                               characterType:(NSInteger)aCharacterType
                                    avatarID:(NSInteger)anAvatarID;

@end
