//
//  RPGViewController.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/17/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Main view controller. Handy to use for login/registration forms.
 *  Supports automatic scroll to next responder.
 */
@interface RPGViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, assign, readwrite) IBOutlet UIScrollView *scrollView;
@property (nonatomic, assign, readwrite) UITextField *activeField;

/**
 *  Template method! Bind linked views to this method with tag.
 *
 *  @param aSender A sender
 */
- (IBAction)userDoneEnteringText:(UITextField *)aSender;

- (IBAction)userTappedView:(UITapGestureRecognizer *)aSender;

@end
