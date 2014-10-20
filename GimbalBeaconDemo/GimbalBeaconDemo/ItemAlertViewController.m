//
//  ItemAlertViewController.m
//  Mappaleo
//
//  Created by Frankie on 7/18/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "ItemAlertViewController.h"
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>

@interface ItemAlertViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UITableView *playListTableView;
@property (strong, nonatomic) AVAudioPlayer* audioPlayer;
@end

@implementation ItemAlertViewController{
    int counter;
    NSArray* tempAudioArray;
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
    counter = 1;
    
    
    tempAudioArray = @[@"2 Zoo Intro",@"6 Chimpance"];
    
    
    self.playListTableView.delegate = self;
    self.playListTableView.dataSource = self;
    
    ///self.playListTableView.layer.cornerRadius = 15;
    //self.playListTableView.layer.masksToBounds = YES;
    
    self.secondView.layer.cornerRadius = 15;
    self.secondView.layer.masksToBounds = YES;
    self.secondView.layer.borderWidth = 2.0;
    self.secondView.layer.borderColor = [UIColor purpleColor].CGColor;
    
}


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return counter;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Transmitter *transmitter = self.transmitters[indexPath.row];
    
    cell.textLabel.text = transmitter.name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self addingAudioForIndex:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)addToPlayListTable{
    counter++;
    [self incrementTableView];
}

- (void)rmvFromPlayListTableTransmitter:(Transmitter*)transmitter{
    
    
    if (transmitter.name != nil && ([self.transmitters indexOfObject:transmitter]< self.transmitters.count)) {
        NSLog(@"%@",transmitter.name);
        counter--;
        [self decrementTableViewWithIndex:[NSIndexPath indexPathForRow:[self.transmitters indexOfObject:transmitter] inSection:0]];
    }
    
}

-(void)addingAudioForIndex:(NSUInteger)index{
   
    NSError *error;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:tempAudioArray[index] ofType:@"mp3"];

    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] error:&error];
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
}

#pragma mark - animation Method

-(void)incrementTableView{
    [self.playListTableView reloadData];
    
    if (self.transmitters.count < 5) {
        [UIView animateWithDuration:0.5
                         animations:^{
                             CGRect theFrame = self.secondView.frame;
                             theFrame.size.height += 80.f;
                             self.secondView.frame = theFrame;
                         }];
    }
    else{
        NSLog(@"%d",85 * (self.transmitters.count - 4));
        self.playListTableView.contentInset = UIEdgeInsetsMake(0, 0, 85 * (self.transmitters.count - 4)  , 0); //values passed are - top, left, bottom, right
    }
    
    
}


-(void)decrementTableViewWithIndex:(NSIndexPath*)indexToDelete{
    [UIView animateWithDuration:0.5
                     animations:^{
                         CGRect theFrame = self.secondView.frame;
                         theFrame.size.height -= 81.f;
                         self.secondView.frame = theFrame;
                         NSLog(@"%d",indexToDelete.row);
                         [self.playListTableView  beginUpdates];
                         [self.playListTableView deleteRowsAtIndexPaths:@[indexToDelete] withRowAnimation:UITableViewRowAnimationNone];
                         [self.playListTableView  endUpdates];
                         [self.transmitters removeObjectAtIndex:indexToDelete.row];
                         
                         }];
}

- (IBAction)cancelButton:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
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
