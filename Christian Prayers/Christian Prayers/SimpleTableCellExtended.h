//
//  SimpleTableCellExtended.h
//  Christian Prayers
//
//  Created by Frankie on 3/23/15.
//  Copyright (c) 2015 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>

@interface SimpleTableCellExtended : UITableViewCell <UITextViewDelegate>
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *extendedInfo;
@property (nonatomic, weak) IBOutlet PFImageView *thumbnailImageView;
@property (nonatomic) CGFloat cellHeight;

-(void)AdjustToFittingHeight;
@end
