//
//  SimpleTableCellExtended.m
//  Christian Prayers
//
//  Created by Frankie on 3/23/15.
//  Copyright (c) 2015 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "SimpleTableCellExtended.h"

@implementation SimpleTableCellExtended

@synthesize nameLabel = _nameLabel;
@synthesize thumbnailImageView = _thumbnailImageView;
@synthesize extendedInfo = _extendedInfo;
@synthesize cellHeight = _cellHeight;


- (void)awakeFromNib {
    // Initialization code
    
    _thumbnailImageView.layer.cornerRadius = _thumbnailImageView.frame.size.width / 2;
    _thumbnailImageView.layer.borderWidth = 3.0f;
    _thumbnailImageView.layer.borderColor = [UIColor grayColor].CGColor;
    _thumbnailImageView.clipsToBounds = YES;
    _extendedInfo.delegate = self;
    
    
   // _cellHeight = 72;
    //[self AdjustToFittingHeight];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(void)AdjustToFittingHeight
{
    CGFloat fixedWidth = _extendedInfo.frame.size.width;
    CGSize newSize = [_extendedInfo sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = _extendedInfo.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    _extendedInfo.frame = newFrame;
   
    _cellHeight = _extendedInfo.frame.size.height;
}


@end
