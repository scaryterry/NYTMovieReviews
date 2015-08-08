//
//  UITableViewCell+APICell.h
//  Movie Reviews
//
//  Created by Christos C on 08/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *const CellIdentifierNormal = @"normalCell";
static NSString *const CellIdentifierSearch = @"resultCell";
@class NYTResults,Results;
@interface UITableViewCell (APICell)
-(void)configureWithResult:(NYTResults *)result;
-(void)configureWithFavourite:(Results *)result;
@end
