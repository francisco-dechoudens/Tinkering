//
//  ViewController.m
//  ScrollableTutorial
//
//  Created by Frankie on 3/27/15.
//  Copyright (c) 2015 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextView *LongTitle;
@property (weak, nonatomic) IBOutlet UITextView *body1;

@property (weak, nonatomic) IBOutlet UITextView *ActionLabel;
@property (weak, nonatomic) IBOutlet UITextView *body2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.LongTitle.text = @".";
    self.body1.text = @"";
    
    
    
    self.ActionLabel.text = @"TEMP";
    self.body2.text = @"I[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];[self setScrollViewLimits];";
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self resizeTextView:_LongTitle];
    [self adjustTextViewPosition:_body1 lastTextView:_LongTitle];
    
    [self resizeTextView:_body1];
     [self adjustTextViewPosition:_ActionLabel lastTextView:_body1];
    
    [self resizeTextView:_ActionLabel];
    
    [self adjustTextViewPosition:_body2 lastTextView:_ActionLabel];
    [self resizeTextView:_body2];
    
    [self setScrollViewLimits];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setScrollViewLimits{
    
    
    self.scrollView.contentSize = CGSizeMake(320, _body2.frame.origin.y + _body2.frame.size.height);
}

-(void)resizeTextView:(UITextView*)textView
{
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

@end
