//
//  RPGBattleManager.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleManager.h"

  // Entities
#import "RPGBattleInitResponse.h"
#import "RPGRequest+Serialization.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"

@interface RPGBattleManager ()

@end

@implementation RPGBattleManager

@synthesize delegate = _delegate;

#pragma mark - Init

#pragma mark - Dealloc

#pragma mark - Actions

- (void)sendSpellActionRequestWithID:(NSInteger)anID
{
	
}

- (void)sendBattleCondtionRequest
{
	
}

- (void)sendTimeSynchRequest
{
	
}

- (void)sendBattleInitRequest
{
  NSError *JSONSerializationError = nil;
  NSString *token = [[NSUserDefaults standardUserDefaults] sessionToken];
  RPGRequest *request = [[RPGRequest alloc] initWithType:@"BATTLE_INIT" token:token];
  
  if (request != nil)
  {
    NSData *data = [NSJSONSerialization dataWithJSONObject:[request dictionaryRepresentation]
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&JSONSerializationError];
    
    if (data == nil)
    {
      [[NSException exceptionWithName:NSInvalidArgumentException
                               reason:@"JSON cannot be retrieved from battle init request"
                             userInfo:nil] raise];
    }
    else
    {
      [self send:data];
    }
  }
  
}




@end
