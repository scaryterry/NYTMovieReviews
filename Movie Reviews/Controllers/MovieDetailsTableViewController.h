//
//  MovieDetailsTableViewController.h
//  Movie Reviews
//
//  Created by Christos C on 09/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Results,NYTResults;
/**
 *  The controller that will display all of the information for the selected movie
 */
@interface MovieDetailsTableViewController : UITableViewController
/**
 *  The selected movie from the online search results
 */
@property (strong, nonatomic) NYTResults *onlineSelection;
/**
 *  The selected movie from the favourites
 */
@property (strong, nonatomic) Results *offlineSelection;

@end
