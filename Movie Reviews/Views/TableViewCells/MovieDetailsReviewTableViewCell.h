//
//  MovieDetailsReviewTableViewCell.h
//  Movie Reviews
//
//  Created by Christos C on 09/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NYTResults;
@interface MovieDetailsReviewTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *allLabels;
@property (weak, nonatomic) IBOutlet UILabel *labelStaticHeader;
@property (weak, nonatomic) IBOutlet UILabel *labelReviewSummary;
@property (weak, nonatomic) IBOutlet UILabel *labelStaticReviewer;
@property (weak, nonatomic) IBOutlet UILabel *labelReviewer;

-(void)configureReviewCellWithResult:(NYTResults *)result;

@end
