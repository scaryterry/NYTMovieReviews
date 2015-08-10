//
//  MovieDetailsDescriptionTableViewCell.m
//  Movie Reviews
//
//  Created by Christos C on 09/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import "NYTResults.h"
#import "MovieDetailsDescriptionTableViewCell.h"
#import "UITableViewCell+Additions.h"
@implementation MovieDetailsDescriptionTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureDescriptionCellWithResult:(NYTResults *)result
{
    [self addText:result.displayTitle toLabel:self.labelTitle];
    [self addText:result.openingDate toLabel:self.labelReleaseDate];
    [self addText:result.dvdReleaseDate toLabel:self.labelDVDReleaseDate];

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
    if (label == self.labelReleaseDate)
    {
        self.labelStaticReleaseDate.hidden = shouldHideLabel;
        if (shouldHideLabel)
        {
            //by removing an element from the superview all its constraints are removed as well so we need additional constraints on the items that wont be removed so that they take into account the fact that some of their constrainst may be removed
            //this removal should only happen if said cell will be displayed on screen only once (so it cant be used so simply in the listing of all movies) since to add it back in we will need to also add its constraints, which is expensive to do at runtime
            [self.labelStaticReleaseDate removeFromSuperview];
        }
    }
    if (label == self.labelDVDReleaseDate)
    {
        self.labelStaticDVDReleaseDate.hidden = shouldHideLabel;
        if (shouldHideLabel)
        {
            [self.labelStaticDVDReleaseDate removeFromSuperview];
        }

    }
    if (label == self.labelTitle)
    {
        self.labelStaticTitle.hidden = shouldHideLabel;
        if (shouldHideLabel)
        {
            [self.labelStaticTitle removeFromSuperview];
        }

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
    [label removeFromSuperview];

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
