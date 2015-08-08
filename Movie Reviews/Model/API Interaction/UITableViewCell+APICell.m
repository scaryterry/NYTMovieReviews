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
    NSString *details;
    //check reuseIdentifier so that we can display different content for each cell
    if ([self.reuseIdentifier isEqualToString:CellIdentifierNormal])
    {
        details = result.capsuleReview;
    }
    else
    {
        details = result.openingDate;
    }
    self.textLabel.text = result.displayTitle;
    self.detailTextLabel.text = details;
    
}


-(void)configureWithFavourite:(Results *)result
{
    NSString *details;
    //check reuseIdentifier so that we can display different content for each cell
    if ([self.reuseIdentifier isEqualToString:CellIdentifierNormal])
    {
        details = result.capsuleReview;
    }
    else
    {
        details = result.openingDate;
    }
    self.textLabel.text = result.displayTitle;
    self.detailTextLabel.text = details;
    
}

@end
