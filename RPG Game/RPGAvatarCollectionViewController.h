//
//  RPGAvatarCollectionViewController.h
//  RPG Game
//
//  Created by Максим Шульга on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPGAvatarCollectionViewController : NSObject

@property (nonatomic, assign, readonly) NSUInteger selectedAvatarIndex;

- (instancetype)initWithCollectionView:(UICollectionView *)aCollectionView
                  parentViewController:(UIViewController *)aViewController;

@end
