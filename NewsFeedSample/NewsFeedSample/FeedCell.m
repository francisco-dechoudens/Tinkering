//
//  FeedCell.m
//  NewsFeedSample
//
//  Created by Tope Abayomi on 11/04/2014.
//  Copyright (c) 2014 App Design Vault. All rights reserved.
//

#import "FeedCell.h"

@implementation FeedCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    
  /*
    UIColor* mainColor = [UIColor colorWithRed:58.0/255 green:153.0/255 blue:216.0/255 alpha:1.0];
    UIColor* mainColorLight = [mainColor colorWithAlphaComponent:0.7];
    
    UIColor* neutralColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    
    NSString* fontName = @"Avenir-Book";
    NSString* boldFontName = @"Avenir-Heavy";
    
*/
    UIColor* mainColor = [UIColor colorWithRed:216.0/255 green:58.0/255 blue:58.0/255 alpha:1.0];
    UIColor* mainColorLight = [mainColor colorWithAlphaComponent:0.7];
    
    UIColor* neutralColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    
    NSString* fontName = @"EuphemiaUCAS";
    NSString* boldFontName = @"EuphemiaUCAS-Bold";
    
    
    self.nameLabel.textColor =  mainColor;
    self.nameLabel.font =  [UIFont fontWithName:boldFontName size:14.0f];
    
    
    
    self.updateLabel.textColor = neutralColor;
    self.updateLabel.font =  [UIFont fontWithName:fontName size:12.0f];
    
    
    
    self.dateLabel.textColor = neutralColor;
    self.dateLabel.font =  [UIFont fontWithName:fontName size:8.0f];
    
    self.commentCountLabel.textColor = mainColorLight;
    self.commentCountLabel.font =  [UIFont fontWithName:fontName size:10.0f];
    
    self.likeCountLabel.textColor = mainColorLight;
    self.likeCountLabel.font =  [UIFont fontWithName:fontName size:10.0f];
    
    
    
    self.picImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.picImageView.clipsToBounds = YES;
    self.picImageView.layer.cornerRadius = 2.0f;
    
    self.picImageContainer.backgroundColor = [UIColor whiteColor];
    self.picImageContainer.layer.borderColor = [UIColor colorWithWhite:0.8f alpha:0.6f].CGColor;
    self.picImageContainer.layer.borderWidth = 1.0f;
    self.picImageContainer.layer.cornerRadius = 2.0f;

    
    
    
     self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.cornerRadius = 7.0f;
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


/*
UIColor* mainColor = [UIColor colorWithRed:216.0/255 green:58.0/255 blue:58.0/255 alpha:1.0];
UIColor* mainColorLight = [mainColor colorWithAlphaComponent:0.7];

UIColor* neutralColor = [UIColor colorWithWhite:0.7 alpha:1.0];

NSString* fontName = @"EuphemiaUCAS";
NSString* boldFontName = @"EuphemiaUCAS-Bold";
*/

@end
