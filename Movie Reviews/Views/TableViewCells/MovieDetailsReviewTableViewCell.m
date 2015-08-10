//
//  MovieDetailsReviewTableViewCell.m
//  Movie Reviews
//
//  Created by Christos C on 09/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import "MovieDetailsReviewTableViewCell.h"
#import "NYTResults.h"
#import "UITableViewCell+Additions.h"
@implementation MovieDetailsReviewTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)configureReviewCellWithResult:(NYTResults *)result
{

    [self addText:result.capsuleReview toLabel:self.labelReviewSummary];
    
    [self addText:result.byline toLabel:self.labelReviewer];
    
    [self fixCellLayout];
}
-(void)addText:(NSString *)text toLabel:(UILabel *)label
{
    BOOL shouldHideLabel;
    if (text && text.length > 0)
    {
        shouldHideLabel = false;
        label.text = text;
    }
    else
    {
        shouldHideLabel = true;
    }
    [self toggleVisibilityOfLabel:label visibilityStatus:shouldHideLabel];
    
}
-(void)toggleVisibilityOfLabel:(UILabel *)label visibilityStatus:(BOOL)shouldHideLabel
{
    if (label == self.labelReviewer)
    {
        self.labelStaticReviewer.hidden = shouldHideLabel;
    }
    
    
    if (shouldHideLabel == true)
    {
        [self removeLabel:label];
    }
    
    label.hidden = shouldHideLabel;
}
-(void)removeLabel:(UILabel *)label
{
    label.text = @"";
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    for (UILabel *label in self.allLabels)
    {
        label.preferredMaxLayoutWidth = label.frame.size.width;
    }
    [super layoutSubviews];
}

@end
