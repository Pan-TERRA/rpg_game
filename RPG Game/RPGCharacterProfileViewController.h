//
//  RPGCharacterProfileViewController.h
//  RPG Game
//
//  Created by Максим Шульга on 11/16/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
  // Constants
#import "RPGItemTypes.h"

@interface RPGCharacterProfileViewController : UIViewController

  // must be set
@property (nonatomic, assign, readonly) IBOutlet UICollectionView *skillCollectionView;
@property (nonatomic, assign, readonly) IBOutlet UICollectionView *bagCollectionView;
@property (nonatomic, assign, readonly) NSUInteger characterLevel;

@end
