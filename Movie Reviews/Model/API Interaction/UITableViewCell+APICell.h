//
//  UITableViewCell+APICell.h
//  Movie Reviews
//
//  Created by Christos C on 08/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieDetailsHeaderTableViewCell.h"
#import "MovieListTableViewCell.h"
#import "UITableViewCell+Additions.h"

static NSString *const CellIdentifierNormal = @"NormalCell";
static NSString *const CellIdentifierSearch = @"ResultCell";
static NSString *const CellIdentifierMovieDetailsHeader = @"MovieDetailsHeaderTableViewCell";
static NSString *const CellIdentifierMovieList = @"MovieListTableViewCell";

@class NYTResults,Results;
@interface UITableViewCell (APICell)
-(void)configureWithResult:(NYTResults *)result;
-(void)configureWithFavourite:(Results *)result;
@end
