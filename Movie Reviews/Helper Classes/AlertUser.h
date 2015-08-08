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
@interface AlertUser : NSObject
+(void)disableUserInteractionWithView:(UIView *)view displayActivityIndicator:(BOOL) displayIndicator;

+(void)enableUserInteractionWithView:(UIView *)view hideActivityIndicator:(BOOL) hideIndicator;

+(void)setUserInteractionOfView:(UIView *)view to:(BOOL)interactionStatus;

+(BOOL)hideActivityIndicatorFromView:(UIView *)view;

+(void)showActivityIndicatorInCenterOfView:(UIView *)view;

+(void)showActivityIndicatorInView:(UIView *)view withCenter:(CGPoint)customCenter;


+ (void)showFinalProgressHUDAddedTo:(UIView *)view  withMessage:(NSString *)message isSuccessFull:(BOOL)success dismissAfterDelay:(NSTimeInterval)delay animated:(BOOL)animated;


+ (MBProgressHUD *)showInitialProgressHUDAddedTo:(UIView *)view withMessage:(NSString *)message animated:(BOOL)animated;

+ (MBProgressHUD *)modifyProgressHUDInView:(UIView *)view withMessage:(NSString *)message;

+ (BOOL)hideProgressHUDForView:(UIView *)view animated:(BOOL)animated;


+ (void)showError:(NSString *)error customTitle:(NSString *) sentTitleMessage;


+ (void)showSuccess:(NSString *) sentSuccessMessage customTitleMessage:(NSString *) customTitleMessage;


@end
