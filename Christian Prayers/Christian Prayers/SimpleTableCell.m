//
//  SimpleTableCell.m
//  Christian Prayers
//
//  Created by Frankie on 3/13/15.
//  Copyright (c) 2015 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "SimpleTableCell.h"

@implementation SimpleTableCell

@synthesize nameLabel = _nameLabel;
@synthesize thumbnailImageView = _thumbnailImageView;


- (void)awakeFromNib {
    // Initialization code
    
    _thumbnailImageView.layer.cornerRadius = _thumbnailImageView.frame.size.width / 2;
    _thumbnailImageView.layer.borderWidth = 3.0f;
    _thumbnailImageView.layer.borderColor = [UIColor grayColor].CGColor;
    _thumbnailImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
