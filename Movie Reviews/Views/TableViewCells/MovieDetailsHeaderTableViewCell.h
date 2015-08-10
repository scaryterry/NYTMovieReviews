//
//  MovieDetailsHeaderTableViewCell.h
//  Movie Reviews
//
//  Created by Christos C on 09/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NYTResults;

@interface MovieDetailsHeaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelCriticsPick;
@property (weak, nonatomic) IBOutlet UILabel *labelReviewer;
@property (weak, nonatomic) IBOutlet UILabel *labelRating;
@property (weak, nonatomic) IBOutlet UILabel *labelStaticReviewer;
@property (weak, nonatomic) IBOutlet UILabel *labelStaticRating;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *allLabels;

-(void)configureHeaderCellWithResult:(NYTResults *)result;

@end
