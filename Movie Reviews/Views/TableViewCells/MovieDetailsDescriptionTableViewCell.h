//
//  MovieDetailsDescriptionTableViewCell.h
//  Movie Reviews
//
//  Created by Christos C on 09/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NYTResults,Results;
/**
 *  The cell that will be used to display additional information for a movie
 */
@interface MovieDetailsDescriptionTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *allLabels;

@property (weak, nonatomic) IBOutlet UILabel *labelStaticHeader;
@property (weak, nonatomic) IBOutlet UILabel *labelStaticTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelStaticReleaseDate;
@property (weak, nonatomic) IBOutlet UILabel *labelReleaseDate;
@property (weak, nonatomic) IBOutlet UILabel *labelStaticDVDReleaseDate;
@property (weak, nonatomic) IBOutlet UILabel *labelDVDReleaseDate;
/**
 *  Sets the cell's labels from the online search results
 *
 *  @param result The selected movie
 */
-(void)configureDescriptionCellWithResult:(NYTResults *)result;

/**
 *  Sets the cell's labels from the user's favourites
 *
 *  @param result The selected movie
 */
-(void)configureDescriptionCellWithFavourite:(Results *)result;

@end
