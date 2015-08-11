//
//  AlertUser.h
//  Movie Reviews
//
//  Created by Christos C on 08/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MBProgressHUD;
#import <UIKit/UIKit.h>
#import "NSError+Additions.h"
/**
 *  Root class that is responsible for all user interaction
 */
@interface AlertUser : NSObject
//The following methods can display/hide an activity indicator and disable user interaction - used when we dont want the user for example ti keep pressing a button
+(void)disableUserInteractionWithView:(UIView *)view displayActivityIndicator:(BOOL) displayIndicator;
+(void)enableUserInteractionWithView:(UIView *)view hideActivityIndicator:(BOOL) hideIndicator;
+(void)setUserInteractionOfView:(UIView *)view to:(BOOL)interactionStatus;

//The following methods can display or hide an activity indicator in a UIView without stopping user interaction
+(BOOL)hideActivityIndicatorFromView:(UIView *)view;
+(void)showActivityIndicatorInCenterOfView:(UIView *)view;
+(void)showActivityIndicatorInView:(UIView *)view withCenter:(CGPoint)customCenter;

// The following methods present a HUD that would interrupt the user's workflow to display a message
+ (MBProgressHUD *)showInitialProgressHUDAddedTo:(UIView *)view withMessage:(NSString *)message animated:(BOOL)animated;
+ (MBProgressHUD *)modifyProgressHUDInView:(UIView *)view withMessage:(NSString *)message;
+ (void)showFinalProgressHUDAddedTo:(UIView *)view  withMessage:(NSString *)message isSuccessFull:(BOOL)success dismissAfterDelay:(NSTimeInterval)delay animated:(BOOL)animated;
+ (BOOL)hideProgressHUDForView:(UIView *)view animated:(BOOL)animated;

// The following methods present an alert to display a message without interrupting the user's workflow
+ (void)showError:(NSString *)error customTitle:(NSString *) sentTitleMessage;
+ (void)showSuccess:(NSString *) sentSuccessMessage customTitleMessage:(NSString *) customTitleMessage;


@end
