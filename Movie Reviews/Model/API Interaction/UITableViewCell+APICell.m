//
//  UITableViewCell+APICell.m
//  Movie Reviews
//
//  Created by Christos C on 08/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import "UITableViewCell+APICell.h"

#import "DataModels.h"

@implementation UITableViewCell (APICell)
-(void)configureWithResult:(NYTResults *)result
{
    //check reuseIdentifier so that we can display different content for each cell
       if ([self.reuseIdentifier isEqualToString:CellIdentifierSearch])
    {
        //        details = result.openingDate;
        self.textLabel.text = result.displayTitle;
        self.detailTextLabel.text = result.openingDate;
    }
    
    if ([self.reuseIdentifier isEqualToString:CellIdentifierMovieList])
    {
        [((MovieListTableViewCell *)self) configureListCellWithResult:result];
    }
    else if ([self.reuseIdentifier isEqualToString:CellIdentifierMovieDetailsHeader])
    {
        [((MovieDetailsHeaderTableViewCell *)self) configureHeaderCellWithResult:result];
    }
    else if ([self.reuseIdentifier isEqualToString:CellIdentifierMovieDetailsReview])
    {
        [((MovieDetailsReviewTableViewCell *)self) configureReviewCellWithResult:result];
    }
    else if ([self.reuseIdentifier isEqualToString:CellIdentifierMovieDetailsDescription])
    {
        [((MovieDetailsDescriptionTableViewCell *)self) configureDescriptionCellWithResult:result];
    }
    //    else
    //    {
    //        self.textLabel.text = result.displayTitle;
    //        self.detailTextLabel.text = details;
    //    }
    
}


-(void)configureWithFavourite:(Results *)result
{
    //check reuseIdentifier so that we can display different content for each cell
    if ([self.reuseIdentifier isEqualToString:CellIdentifierSearch])
    {
        //        details = result.openingDate;
        self.textLabel.text = result.displayTitle;
        self.detailTextLabel.text = result.openingDate;
    }
    
    if ([self.reuseIdentifier isEqualToString:CellIdentifierMovieList])
    {
        [((MovieListTableViewCell *)self) configureListCellWithFavourite:result];
    }
    else if ([self.reuseIdentifier isEqualToString:CellIdentifierMovieDetailsHeader])
    {
        [((MovieDetailsHeaderTableViewCell *)self) configureHeaderCellWithFavourite:result];
    }
    else if ([self.reuseIdentifier isEqualToString:CellIdentifierMovieDetailsReview])
    {
        [((MovieDetailsReviewTableViewCell *)self) configureReviewCellWithFavourite:result];
    }
    else if ([self.reuseIdentifier isEqualToString:CellIdentifierMovieDetailsDescription])
    {
        [((MovieDetailsDescriptionTableViewCell *)self) configureDescriptionCellWithFavourite:result];
    }
    //    else
    //    {
    //        self.textLabel.text = result.displayTitle;
    //        self.detailTextLabel.text = details;
    //    }
    
}
@end
