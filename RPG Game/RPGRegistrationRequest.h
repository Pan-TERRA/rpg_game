//
//  RPGRegistrationRequest.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 10/14/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPGRegistrationRequest : NSObject

@property (copy, nonatomic, readonly) NSString *username;
@property (copy, nonatomic, readonly) NSString *email;
@property (copy, nonatomic, readonly) NSString *password;
@property (copy, nonatomic, readonly) NSString *characterName;
@property (readonly) NSInteger characterType;

- (instancetype)initWithEmail:(NSString *)anEmail
                     password:(NSString *)aPassword
                     username:(NSString *)aUsername
                characterName:(NSString *)aCharacterName
                characterType:(NSInteger)aCharacterType NS_DESIGNATED_INITIALIZER;
+ (instancetype)registrationRequestWithEmail:(NSString *)anEmail
                                    password:(NSString *)aPassword
                                    username:(NSString *)aUsername
                               characterName:(NSString *)aCharacterName
                               characterType:(NSInteger)aCharacterType;

@end
