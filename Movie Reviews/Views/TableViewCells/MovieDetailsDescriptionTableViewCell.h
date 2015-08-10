//
//  MovieDetailsDescriptionTableViewCell.h
//  Movie Reviews
//
//  Created by Christos C on 09/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NYTResults;
@interface MovieDetailsDescriptionTableViewCell : UITableViewCell
-(void)configureDescriptionCellWithResult:(NYTResults *)result;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *allLabels;

@property (weak, nonatomic) IBOutlet UILabel *labelStaticHeader;
@property (weak, nonatomic) IBOutlet UILabel *labelStaticTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelStaticReleaseDate;
@property (weak, nonatomic) IBOutlet UILabel *labelReleaseDate;
@property (weak, nonatomic) IBOutlet UILabel *labelStaticDVDReleaseDate;
@property (weak, nonatomic) IBOutlet UILabel *labelDVDReleaseDate;

@end
