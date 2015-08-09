//
//  MovieDetailsTableViewController.h
//  Movie Reviews
//
//  Created by Christos C on 09/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Results,NYTResults;

@interface MovieDetailsTableViewController : UITableViewController

@property (strong, nonatomic) NYTResults *onlineSelection;
@property (strong, nonatomic) Results *offlineSelection;
@end
