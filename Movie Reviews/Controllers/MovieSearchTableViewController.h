//
//  MovieSearchTableViewController.h
//  Movie Reviews
//
//  Created by Christos C on 07/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  The Controller with which users can search the NYT Movie Reviews API and view the results. It uses the deprecated searchDisplayController to maintain compatibility with iOS 7. Search occurs 0.4 seconds after each letter is typed, if another letter is typed in those 0.4 seconds then the previous search request gets cancelled. This way the search doesnt send any requests we dont want it to. 
 */
@interface MovieSearchTableViewController : UITableViewController

@end
