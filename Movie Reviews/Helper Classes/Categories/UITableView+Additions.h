//
//  UITableView+Additions.h
//  Movie Reviews
//
//  Created by Christos C on 08/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Additions)
- (void)showTableMessage:(NSString *)text;
- (void)showTableMessage:(NSString *)text atPosition:(CGPoint)position;

@end
