//
//  VerseViewController.m
//  Christian Prayers
//
//  Created by Frankie on 3/27/15.
//  Copyright (c) 2015 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "VerseViewController.h"

@interface VerseViewController ()

@end

@implementation VerseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    [self resizeView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setScrollViewLimits{
    
    
    self.scrollView.contentSize = CGSizeMake(320, _actionBody.frame.origin.y + _actionBody.frame.size.height);
}

-(void)resizeView{
    
    [self resizeTextView:_actionLabel1];
    
    
    [self adjustTextViewPosition:_verseBody lastTextView:_actionLabel1];
    
    [self resizeTextView:_verseBody];
    [self adjustTextViewPosition:_actionLabel2 lastTextView:_verseBody];
    
    [self resizeTextView:_actionLabel2];
    
    [self adjustTextViewPosition:_actionBody lastTextView:_actionLabel2];
    [self resizeTextView:_actionBody];
    
    [self setScrollViewLimits];
}

-(void)resizeTextView:(UITextView*)textView
{
    _actionLabel1.font = [UIFont boldSystemFontOfSize:12];
    _actionLabel2.font = [UIFont boldSystemFontOfSize:12];
    
    CGFloat fixedWidth = textView.frame.size.width;
    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = textView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    
    textView.frame = newFrame;
    
    
    
    
}

-(void)adjustTextViewPosition:(UITextView*)movingTextView lastTextView:(UITextView*)lastTextView
{
    
    
    [movingTextView setFrame:CGRectMake(lastTextView.frame.origin.x, lastTextView.frame.origin.y + lastTextView.frame.size.height +10, 320.0, 200)];
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
