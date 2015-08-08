//
//  UITableView+Additions.m
//  Movie Reviews
//
//  Created by Christos C on 08/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import "UITableView+Additions.h"

@implementation UITableView (Additions)

- (void)showTableMessage:(NSString *)text
{
    [self showTableMessage:text atPosition:self.center];
}

- (void)showTableMessage:(NSString *)text atPosition:(CGPoint)position
{
    // Display a message when the table is empty
    CGRect frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:frame];
    messageLabel.center = position;
    messageLabel.text = text;
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont fontWithName:@"Palatino-Italic" size:20];
    [messageLabel sizeToFit];
    
    self.tableFooterView = messageLabel;
    
}


@end
