//
//  MovieDetailsReviewTableViewCell.h
//  Movie Reviews
//
//  Created by Christos C on 09/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NYTResults,Results;
/**
 *  The cell that will be used to display the avialable review for a movie
 */
@interface MovieDetailsReviewTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *allLabels;
@property (weak, nonatomic) IBOutlet UILabel *labelStaticHeader;
@property (weak, nonatomic) IBOutlet UILabel *labelReviewSummary;
@property (weak, nonatomic) IBOutlet UILabel *labelStaticReviewer;
@property (weak, nonatomic) IBOutlet UILabel *labelReviewer;
/**
 *  Sets the cell's labels from the online search results
 *
 *  @param result The selected movie
 */
-(void)configureReviewCellWithResult:(NYTResults *)result;

/**
 *  Sets the cell's labels from the user's favourites
 *
 *  @param result The selected movie
 */
-(void)configureReviewCellWithFavourite:(Results *)result;

@end
