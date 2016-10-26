//
//  RPGStatusCodes.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const RPGStatusCodeDescription[];

typedef NS_ENUM(NSInteger, RPGStatusCode)
{
    // Server Status Codes
  kRPGStatusCodeOk,
  kRPGStatusCodeWrongJSON,
  kRPGStatusCodeUserDoesNotExist,
  kRPGStatusCodeWrongPassword,
  kRPGStatusCodeWrongToken,
  kRPGStatusCodeUsernameIsAlreadyTaken,
  kRPGStatusCodeEmailIsAlreadyTaken,
  
    // RPGNetworkManager Status Codes
  kRPGStatusCodeNetworkManagerUnknown = 1700,
  kRPGStatusCodeNetworkManagerEmptyResponseData = 1701,
  kRPGStatusCodeNetworkManagerServerError = 1702,
  kRPGStatusCodeNetworkManagerSerializingError = 1703,
  kRPGStatusCodeNetworkManagerNoInternetConnection = 1704,
  kRPGStatusCodeNetworkManagerResponseObjectValidationFail = 1705
};
