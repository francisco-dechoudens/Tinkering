//
//  VerseViewController.h
//  Christian Prayers
//
//  Created by Frankie on 3/27/15.
//  Copyright (c) 2015 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerseViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *actionLabel1;
@property (weak, nonatomic) IBOutlet UITextView *verseBody;
@property (weak, nonatomic) IBOutlet UITextView *actionLabel2;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextView *actionBody;

-(void)resizeView;
@end
