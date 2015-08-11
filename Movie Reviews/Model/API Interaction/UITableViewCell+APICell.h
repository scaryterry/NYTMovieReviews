//
//  UITableViewCell+APICell.h
//  Movie Reviews
//
//  Created by Christos C on 08/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieDetailsHeaderTableViewCell.h"
#import "MovieDetailsReviewTableViewCell.h"
#import "MovieDetailsDescriptionTableViewCell.h"

#import "MovieListTableViewCell.h"

#import "UITableViewCell+Additions.h"

static NSString *const CellIdentifierNormal = @"NormalCell";
static NSString *const CellIdentifierSearch = @"ResultCell";
static NSString *const CellIdentifierMovieDetailsHeader = @"MovieDetailsHeaderTableViewCell";
static NSString *const CellIdentifierMovieDetailsReview  = @"MovieDetailsReviewTableViewCell";
static NSString *const CellIdentifierMovieDetailsDescription = @"MovieDetailsDescriptionTableViewCell";
static NSString *const CellIdentifierMovieDetailsOverview = @"MovieDetailsOverviewTableViewCell";

static NSString *const CellIdentifierMovieList = @"MovieListTableViewCell";

@class NYTResults,Results;
/**
 *  Class used by any tableview that wants to display a favourite or a search result. All that we have to do is set the correct reuse identifier for the cell we want to configure.
 */
@interface UITableViewCell (APICell)

/**
 *  Used by any tableview that wants to configure a cell with a movie search result from the NYT API
 *
 *  @param result The datasource the cells will be configured with
 */
-(void)configureWithResult:(NYTResults *)result;

/**
 *  Used by any tableview that wants to configure a cell with a movie from favourites stored with core data
 *
 *  @param result The datasource the cells will be configured with
 */
-(void)configureWithFavourite:(Results *)result;

@end
