//
//  UIDevice+Additions.h
//  Movie Reviews
//
//  Created by Christos C on 11/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIDeviceInstance ([UIDevice currentDevice])

/** Helper category to get different info about the device.
 */
@interface UIDevice (Additions)

/** Tells whether the current device is an iPad.
 */
+ (BOOL)isiPad;

/** Returns the current device model.
 */
+ (NSString *)deviceModel;

/** Returns the major version of the operating system.
 */
+ (NSInteger)majorSystemVersion;

@end
