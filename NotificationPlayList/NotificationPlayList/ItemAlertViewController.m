//
//  ItemAlertViewController.m
//  Mappaleo
//
//  Created by Frankie on 7/18/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "ItemAlertViewController.h"

@interface ItemAlertViewController ()

@end

@implementation ItemAlertViewController{
    int count;
    int selectedIndex;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        //sets two UIViewController properties
        self.modalPresentationStyle = UIModalPresentationCustom; //we’re going to supply a custom transition animation
        self.transitioningDelegate = self; //reveal where the custom transition animation is to come from
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    count = 1;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.hidden = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tableView.hidden = NO;
    self.tableView.frame=CGRectMake(self.tableView.frame.origin.x,self.backgroundView.frame.origin.y*2,self.tableView.frame.size.width,self.tableView.frame.size.height);
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         UITableViewCell* cell = [self tableView:self.tableView cellForRowAtIndexPath:0];
                         self.tableView.frame=CGRectMake(self.tableView.frame.origin.x,self.backgroundView.frame.origin.y*2-5+cell.frame.size.height,self.tableView.frame.size.width,self.tableView.frame.size.height);
                         [self.tableView reloadData];
                     }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.totalNumberVideo.text = [NSString stringWithFormat:@"%d",count];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    if (indexPath.row == selectedIndex) {
      UIImageView *arrowIcon = (UIImageView*)[cell viewWithTag:100];
        arrowIcon.hidden = NO;
        UILabel *numberLabel = (UILabel*)[cell viewWithTag:101];
        numberLabel.hidden = YES;
    }
    else{
        UIImageView *arrowIcon = (UIImageView*)[cell viewWithTag:100];
        arrowIcon.hidden = YES;
        UILabel *numberLabel = (UILabel*)[cell viewWithTag:101];
        numberLabel.hidden = NO;
        numberLabel.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.currentNumberVideo.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
    selectedIndex = indexPath.row;
    [self.tableView reloadData];
}

//pointing to an object that will provide the actual custom PRESENT transition animation
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:
(UIViewController *)presented
                                                                 presentingController:(UIViewController *)presenting
                                                                     sourceController:(UIViewController *)source
{
    return self;
}
//pointing to an object that will provide the actual custom DISMISS transition animation
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}

//a method that reveals the duration of the animation:
-(NSTimeInterval)transitionDuration:
(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (IBAction)cancelButton:(id)sender {
    self.tableView.hidden = NO;
    if(count < 3) {
        
        ++count;
        [self.tableView reloadData];
        self.tableView.frame=CGRectMake(self.tableView.frame.origin.x,self.tableView.frame.origin.y,self.tableView.frame.size.width,self.tableView.frame.size.height);
        [UIView animateWithDuration:0.5
                         animations:^{
                             UITableViewCell* cell = [self tableView:self.tableView cellForRowAtIndexPath:0];
                             self.tableView.frame=CGRectMake(self.tableView.frame.origin.x,self.tableView.frame.origin.y,self.tableView.frame.size.width,self.tableView.frame.size.height+cell.frame.size.height);}];
    }
    else{
        ++count;
        [self.tableView reloadData];
    }
}
//the actual custom transition animation
-(void)animateTransition:
(id<UIViewControllerContextTransitioning>)transitionContext {
    
    //The two view controllers involved in the transition
    UIViewController* vc1 =
    [transitionContext viewControllerForKey:
     UITransitionContextFromViewControllerKey];
    
    UIViewController* vc2 =
    [transitionContext viewControllerForKey:
     UITransitionContextToViewControllerKey];
    
    //The special container view inside which the views of those two view controllers will appear.
    UIView* con = [transitionContext containerView];
    
    UIView* v1 = vc1.view;
    UIView* v2 = vc2.view;
    
    if (vc2 == self) { // presenting
        [con addSubview:v2];
        v2.frame = v1.frame; //“shadow view” - its frame will be the same as the frame of the original view behind it
        self.backgroundView.transform = CGAffineTransformMakeScale(1.6,1.6); // for animate our view from large to normal(Scaling factor by which to scale 1.6)
        v2.alpha = 0; //we will animate our view from invisible to visible
        v1.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
        [UIView animateWithDuration:0.25 animations:^{
            v2.alpha = 1;
          
            self.backgroundView.transform = CGAffineTransformIdentity; //Checks whether an affine transform is the identity transform
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
    else { // dismissing
        [UIView animateWithDuration:0.25 animations:^{
            self.backgroundView.transform = CGAffineTransformMakeScale(1,1);
            v1.alpha = 0;
        } completion:^(BOOL finished) {
            v2.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
            [transitionContext completeTransition:YES];
        }];
    }
}

@end
