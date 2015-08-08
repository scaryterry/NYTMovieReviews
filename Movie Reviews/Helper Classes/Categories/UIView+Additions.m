//
//  UIView+Additions.m
//  Movie Reviews
//
//  Created by Christos C on 08/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)
BOOL shouldRotate;

-(void)startViewRotation
{
    shouldRotate = true;
    [self applyRotation];
}
- (void)stopViewRotation
{
    shouldRotate = false;
    [self applyRotation];// if this method is not called and only the above bool is turned off then the rotation will stop at 180 degrees instead of completing the circle and stopping
}

- (void)applyRotation
{
    
    NSTimeInterval duration = 2.0f;
    UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState  |UIViewAnimationOptionAllowUserInteraction   | UIViewAnimationOptionCurveLinear;
    [UIView animateWithDuration:duration delay:0.0 options:options animations:^
     {
         CGAffineTransform rotateTransform;
         if (shouldRotate)
         {
             rotateTransform = CGAffineTransformRotate(self.transform, M_PI);
         }
         else
         {
             rotateTransform  = CGAffineTransformMakeRotation(0);
         }
         self.transform = rotateTransform;
     }
                     completion:^(BOOL finished) {
                         if (shouldRotate)
                         {
                             [self startViewRotation];
                         }
                     }];
    
}


-(void)setUserInteractionTo:(BOOL)interactionStatus
{
    self.userInteractionEnabled = interactionStatus;
    if ([self respondsToSelector:@selector(setEnabled:)])
    {
        [self performSelector:@selector(setEnabled:) withObject:[NSNumber numberWithBool:interactionStatus]];
    }
}

-(BOOL)hideActivityIndicator
{
    BOOL status = false;
    
    UIActivityIndicatorView *indicator = ([[self viewWithTag:tagActivityIndicatorView] isKindOfClass:[UIActivityIndicatorView class]]) ?  (UIActivityIndicatorView *)[self viewWithTag:tagActivityIndicatorView]:nil;
    status = (indicator == nil) ? false:true;
    if (status)
    {
        [indicator stopAnimating];
        [indicator removeFromSuperview];
    }
    return status;
}

-(void)showActivityIndicatorInCenter
{
    CGPoint activityCenter = self.center;
    [self showActivityIndicatorWithCenter:activityCenter];
}

-(void)showActivityIndicatorWithCenter:(CGPoint)customCenter
{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.tag = tagActivityIndicatorView;
    indicator.hidesWhenStopped = true;
    indicator.center = customCenter;
    [self addSubview:indicator];
    [indicator startAnimating];
}
@end
