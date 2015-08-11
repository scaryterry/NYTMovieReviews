//
//  UIView+Additions.h
//  Movie Reviews
//
//  Created by Christos C on 08/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#define tagActivityIndicatorView 228484894
#define nilCenterActivityIndicatorView CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX))
/**
 *  Helper category on UIView that deals with user interaction - displaying activity indicator, rotating a view(like an update button) etc
 */
@interface UIView (Additions)

- (void)startViewRotation;
- (void)stopViewRotation;

- (void)setUserInteractionTo:(BOOL)interactionStatus;
- (BOOL)hideActivityIndicator;
- (void)showActivityIndicatorInCenter;
- (void)showActivityIndicatorWithCenter:(CGPoint)customCenter;

@end
