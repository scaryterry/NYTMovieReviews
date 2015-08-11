//
//  MovieDetailsHeaderTableViewCell.h
//  Movie Reviews
//
//  Created by Christos C on 09/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NYTResults;
@class Results;
/**
 *  The header cell for a movie, contains several different types of information
 */
@interface MovieDetailsHeaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelCriticsPick;
@property (weak, nonatomic) IBOutlet UILabel *labelReviewer;
@property (weak, nonatomic) IBOutlet UILabel *labelRating;
@property (weak, nonatomic) IBOutlet UILabel *labelStaticReviewer;
@property (weak, nonatomic) IBOutlet UILabel *labelStaticRating;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *allLabels;
/**
 *  Sets the cell's labels from the online search results
 *
 *  @param result The selected movie
 */
-(void)configureHeaderCellWithResult:(NYTResults *)result;

/**
 *  Sets the cell's labels from the user's favourites
 *
 *  @param result The selected movie
 */
-(void)configureHeaderCellWithFavourite:(Results *)result;

@end
