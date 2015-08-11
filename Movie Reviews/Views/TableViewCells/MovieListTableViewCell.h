//
//  MovieListTableViewCell.h
//  Movie Reviews
//
//  Created by Christos C on 09/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NYTResults,Results;
/**
 *  The cell that will be used throughout the app whenever a list with a lot of cells is required 
 */
@interface MovieListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelStaticReview;
@property (weak, nonatomic) IBOutlet UILabel *labelReview;
@property (weak, nonatomic) IBOutlet UILabel *labelStaticBy;
@property (weak, nonatomic) IBOutlet UILabel *labelReviewer;
@property (weak, nonatomic) IBOutlet UILabel *labelStaticReviewDate;
@property (weak, nonatomic) IBOutlet UILabel *labelReviewDate;
@property (weak, nonatomic) IBOutlet UILabel *labelCriticsPick;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *allLabels;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintReviewToDate;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintReviewLabelToDate;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintCrtiticsToReviewer;
/**
 *  Sets the cell's labels from the online search results
 *
 *  @param result The selected movie
 */
-(void)configureListCellWithResult:(NYTResults *)result;

/**
 *  Sets the cell's labels from the user's favourites
 *
 *  @param result The selected movie
 */
-(void)configureListCellWithFavourite:(Results *)result;

@end
