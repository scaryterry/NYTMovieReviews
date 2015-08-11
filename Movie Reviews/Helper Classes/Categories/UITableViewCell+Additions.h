//
//  UITableViewCell+Additions.h
//  Movie Reviews
//
//  Created by Christos C on 09/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Category on tableViewCell with additional helper methods.
 */
@interface UITableViewCell (Additions)
/**
 *  This method needs to be called when configuring each cell, its the only way to ensure that all the elements in the cell are sized correctly
 */
-(void)fixCellLayout;
/**
 *  Category method used on iOS7 to calculate and return the cell height using autolayout
 *
 *
 *  @return The calculated height of the cell
 */
-(CGFloat)returnCellAutoHeight;

/**
 *  Method that changes how the cells get presented on screen, should be called from the willDisplayCell tableView Delegate method
 */
-(void)animateCellScrolling;
@end
