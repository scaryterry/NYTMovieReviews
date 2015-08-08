//
//  AlertUser.m
//  Movie Reviews
//
//  Created by Christos C on 08/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import "AlertUser.h"
#import <TSMessage.h>
#import "UIView+Additions.h"
#import "MBProgressHUD.h"

@implementation AlertUser

+(void)disableUserInteractionWithView:(UIView *)view displayActivityIndicator:(BOOL) displayIndicator
{
    [view setUserInteractionTo:false];
    if (displayIndicator)
    {
        [view showActivityIndicatorInCenter];
    }
}

+(void)enableUserInteractionWithView:(UIView *)view hideActivityIndicator:(BOOL) hideIndicator
{
    [view setUserInteractionTo:true];
    if (hideIndicator)
    {
        [view hideActivityIndicator];
    }
}

+(void)setUserInteractionOfView:(UIView *)view to:(BOOL)interactionStatus
{
    [view setUserInteractionTo:interactionStatus];
}

+(BOOL)hideActivityIndicatorFromView:(UIView *)view
{
    return [view hideActivityIndicator];
}

+(void)showActivityIndicatorInCenterOfView:(UIView *)view
{
    CGPoint activityCenter = view.center;
    [view showActivityIndicatorWithCenter:activityCenter];
}

+(void)showActivityIndicatorInView:(UIView *)view withCenter:(CGPoint)customCenter
{
    //    NSLog(@"adding indicator at center %@", NSStringFromCGPoint(customCenter));
    [view showActivityIndicatorWithCenter:customCenter];
}

+ (void)showFinalProgressHUDAddedTo:(UIView *)view  withMessage:(NSString *)message isSuccessFull:(BOOL)success dismissAfterDelay:(NSTimeInterval)delay animated:(BOOL)animated
{
    MBProgressHUD *hud = [[self class] modifyProgressHUDInView:view withMessage:message];
    hud.detailsLabelText = hud.labelText;
    if (success)
    {
        hud.labelText = @" ";
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tick-ui-icons"]];
    }
    else
    {
        hud.labelText = @" ";
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cross-ui-icons"]];
    }
    hud.mode = MBProgressHUDModeCustomView;
    [hud hide:animated afterDelay:delay];
}

+ (MBProgressHUD *)showInitialProgressHUDAddedTo:(UIView *)view withMessage:(NSString *)message animated:(BOOL)animated
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:animated];
    hud.removeFromSuperViewOnHide = true;
    hud.labelText = message;
    return hud;
}

+ (MBProgressHUD *)modifyProgressHUDInView:(UIView *)view withMessage:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    
    if (hud)
    {
        hud.labelText = message;
    }
    else
    {
        hud = [[self class] showInitialProgressHUDAddedTo:view withMessage:message animated:true];
    }
    return hud;
}
+ (BOOL)hideProgressHUDForView:(UIView *)view animated:(BOOL)animated;
{
    return [MBProgressHUD hideHUDForView:view animated:animated];
}

+ (void)showError:(NSString *)error customTitle:(NSString *) sentTitleMessage
{
    if (sentTitleMessage==nil)
    {
        [TSMessage  showNotificationWithTitle:@"Error" subtitle:error type:TSMessageNotificationTypeError];
    }
    else
    {
        [TSMessage showNotificationWithTitle:sentTitleMessage subtitle:error type:TSMessageNotificationTypeError];
    }
}


+ (void)showSuccess:(NSString *) sentSuccessMessage customTitleMessage:(NSString *) customTitleMessage
{
    if (customTitleMessage==nil)
    {
        [TSMessage showNotificationWithTitle:@"Success" subtitle:sentSuccessMessage type:TSMessageNotificationTypeSuccess];
    }
    else
    {
        [TSMessage showNotificationWithTitle:customTitleMessage  subtitle:sentSuccessMessage type:TSMessageNotificationTypeSuccess];
    }
}


@end
