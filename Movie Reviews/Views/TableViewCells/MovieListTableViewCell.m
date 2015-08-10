//
//  MovieListTableViewCell.m
//  Movie Reviews
//
//  Created by Christos C on 09/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import "MovieListTableViewCell.h"
#import "NYTResults.h"
#import "Results.h"
#import "UITableViewCell+APICell.h"
@implementation MovieListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)configureListCellWithResult:(NYTResults *)result
{
    [self addText:result.displayTitle toLabel:self.labelTitle];
    
    [self addText:result.capsuleReview toLabel:self.labelReview];
    
    [self addText:result.byline toLabel:self.labelReviewer];
    
    [self addText:result.publicationDate toLabel:self.labelReviewDate];
//    self.labelCriticsPick.hidden = ([result.criticsPick boolValue]) ? false :true;
    if ([result.criticsPick boolValue]) {
        self.labelCriticsPick.hidden = false;
        self.constraintCrtiticsToReviewer.constant = 0;
    }
    else
    {
        self.labelCriticsPick.hidden = true;
        self.constraintCrtiticsToReviewer.constant = -self.labelCriticsPick.frame.size.width;
    }
    [self fixCellLayout];
}
-(void)configureListCellWithFavourite:(Results *)result
{
    [self addText:result.displayTitle toLabel:self.labelTitle];
    
    [self addText:result.capsuleReview toLabel:self.labelReview];
    
    [self addText:result.byline toLabel:self.labelReviewer];
    
    [self addText:result.publicationDate toLabel:self.labelReviewDate];
    //    self.labelCriticsPick.hidden = ([result.criticsPick boolValue]) ? false :true;
    if ([result.criticsPick boolValue]) {
        self.labelCriticsPick.hidden = false;
        self.constraintCrtiticsToReviewer.constant = 0;
    }
    else
    {
        self.labelCriticsPick.hidden = true;
        self.constraintCrtiticsToReviewer.constant = -self.labelCriticsPick.frame.size.width;
    }
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
        self.labelStaticBy.hidden = shouldHideLabel;
    }
    else if (label == self.labelReview)
    {
        self.labelStaticReview.hidden = shouldHideLabel;

        if (shouldHideLabel)
        {
            self.constraintReviewToDate.constant = -20;
            self.constraintReviewLabelToDate.constant = -20;
        }
        else
        {
            self.constraintReviewToDate.constant = 8;
            self.constraintReviewLabelToDate.constant = 8;

        }
    }
    else if (label == self.labelReviewDate)
    {
        self.labelStaticReviewDate.hidden = shouldHideLabel;
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
