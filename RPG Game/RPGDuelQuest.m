//
//  RPGDuelQuest.m
//  RPG Game
//
//  Created by Максим Шульга on 12/14/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGDuelQuest.h"
  // Entities
#import "RPGQuestReward.h"
  // Constants
#import "RPGQuestEnum.h"

static NSString * const kRPGDuelQuestProofImageStringURL2 = @"prove_image_2";
static NSString * const kRPGDuelQuestFriendID = @"friend_id";
static NSString * const kRPGDuelQuestFriendUsername = @"username";
static NSString * const kRPGDuelQuestDaysLeft = @"days_left";
static NSString * const kRPGDuelQuestWinner = @"did_win";

@interface RPGDuelQuest ()

@property (nonatomic, copy, readwrite) NSString *proofImageStringURL2;
@property (nonatomic, assign, readwrite) NSInteger friendID;
@property (nonatomic, copy, readwrite) NSString *friendUsername;
@property (nonatomic, assign, readwrite) NSInteger daysLeft;
@property (nonatomic, assign, readwrite, getter=isWinner) BOOL winner;

@end

@implementation RPGDuelQuest

#pragma mark - Init

- (instancetype)initWithType:(RPGQuestType)aType
                     questID:(NSInteger)aQuestID
                        name:(NSString *)aName
                 description:(NSString *)aQuestDescription
                       state:(RPGQuestState)aState
                      reward:(RPGQuestReward *)aReward
                   getReward:(BOOL)hasGotReward
        proofImageStringURL1:(NSString *)aStringURL1
        proofImageStringURL2:(NSString *)aStringURL2
                    friendID:(NSInteger)aFriendID
              friendUsername:(NSString *)aFriendUsername
                    daysLeft:(NSInteger)aDaysLeft
                      winner:(BOOL)isWinner
{
  self = [super initWithType:aType
                     questID:aQuestID
                        name:aName
                 description:aQuestDescription
                       state:aState
                      reward:aReward
                   getReward:hasGotReward
        proofImageStringURL1:aStringURL1];
  
  if (self != nil)
  {
    if (aFriendID < 1 && aState != kRPGQuestStateForReview)
    {
      [self release];
      self = nil;
    }
    else
    {
      _proofImageStringURL2 = [aStringURL2 copy];
      _friendID = aFriendID;
      _friendUsername = [aFriendUsername copy];
      _daysLeft = aDaysLeft;
      _winner = isWinner;
    }
  }
  
  return self;
}

+ (instancetype)duelQuestWithType:(RPGQuestType)aType
                          questID:(NSInteger)aQuestID
                             name:(NSString *)aName
                      description:(NSString *)aQuestDescription
                            state:(RPGQuestState)aState
                           reward:(RPGQuestReward *)aReward
                        getReward:(BOOL)hasGotReward
             proofImageStringURL1:(NSString *)aStringURL1
             proofImageStringURL2:(NSString *)aStringURL2
                         friendID:(NSInteger)aFriendID
                   friendUsername:(NSString *)aFriendUsername
                         daysLeft:(NSInteger)aDaysLeft
                           winner:(BOOL)isWinner
{
  return [[[self alloc] initWithType:aType
                             questID:aQuestID
                                name:aName
                         description:aQuestDescription
                               state:aState
                              reward:aReward
                           getReward:hasGotReward
                proofImageStringURL1:aStringURL1
                proofImageStringURL2:aStringURL2
                            friendID:aFriendID
                      friendUsername:aFriendUsername
                            daysLeft:aDaysLeft
                              winner:isWinner] autorelease];
}

- (instancetype)initWithType:(RPGQuestType)aType
                     questID:(NSInteger)aQuestID
                        name:(NSString *)aName
                 description:(NSString *)aQuestDescription
                       state:(RPGQuestState)aState
                      reward:(RPGQuestReward *)aReward
                   getReward:(BOOL)hasGotReward
        proofImageStringURL1:(NSString *)aStringURL1
{
  return [self initWithType:aType
                    questID:aQuestID
                       name:aName
                description:aQuestDescription
                      state:aState
                     reward:aReward
                  getReward:hasGotReward
       proofImageStringURL1:aStringURL1
       proofImageStringURL2:nil
                   friendID:-1
             friendUsername:nil
                   daysLeft:-1
                     winner:NO];
}

- (instancetype)init
{
  return [self initWithType:-1
                    questID:-1
                       name:nil
                description:nil
                      state:-1
                     reward:nil
                  getReward:YES
       proofImageStringURL1:nil
       proofImageStringURL2:nil
                   friendID:-1
             friendUsername:nil
                   daysLeft:-1
                     winner:NO];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_proofImageStringURL2 release];
  [_friendUsername release];
  
  [super dealloc];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [[[super dictionaryRepresentation] mutableCopy] autorelease];
  
  if (self.proofImageStringURL2)
  {
    dictionaryRepresentation[kRPGDuelQuestProofImageStringURL2] = self.proofImageStringURL2;
  }
  dictionaryRepresentation[kRPGDuelQuestFriendID] = @(self.friendID);
  if (self.friendUsername)
  {
    dictionaryRepresentation[kRPGDuelQuestFriendUsername] = self.friendUsername;
  }
  dictionaryRepresentation[kRPGDuelQuestDaysLeft] = @(self.daysLeft);
  dictionaryRepresentation[kRPGDuelQuestWinner] = @(self.isWinner);
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  RPGQuestReward *reward = [[[RPGQuestReward alloc] initWithDictionaryRepresentation:aDictionary[kRPGQuestReward]] autorelease];
  
  return [self initWithType:[aDictionary[kRPGQuestType] integerValue]
                    questID:[aDictionary[kRPGQuestID] integerValue]
                       name:aDictionary[kRPGQuestName]
                description:aDictionary[kRPGQuestDescription]
                      state:[aDictionary[kRPGQuestState] integerValue]
                     reward:reward
                  getReward:[aDictionary[kRPGQuestGetReward] boolValue]
       proofImageStringURL1:aDictionary[kRPGQuestProofImageStringURL1]
       proofImageStringURL2:aDictionary[kRPGDuelQuestProofImageStringURL2]
                   friendID:[aDictionary[kRPGDuelQuestFriendID] integerValue]
             friendUsername:aDictionary[kRPGDuelQuestFriendUsername]
                   daysLeft:[aDictionary[kRPGDuelQuestDaysLeft] integerValue]
                     winner:[aDictionary[kRPGDuelQuestWinner] boolValue]];
}

@end
