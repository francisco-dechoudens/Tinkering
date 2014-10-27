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

@interface ItemAlertViewController () <UITableViewDataSource,UITableViewDelegate, AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UITableView *playListTableView;
@property (strong, nonatomic) AVAudioPlayer* audioPlayer;
@property (nonatomic, strong) NSTimer* timer;
@property (weak, nonatomic) IBOutlet UISlider *currentTimeSlider;
@property (weak, nonatomic) IBOutlet UILabel *elapsedTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainingTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *mainTitle;
@end

@implementation ItemAlertViewController{
    int counter;
    int currentPlayedAudio;
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
    currentPlayedAudio = 0;
    counter = 1;
    
    
    tempAudioArray = @[@"2 Zoo Intro",@"6 Chimpance",@"8 Sapo Concho",@"15 Culebra Maicera"];
    
    
    self.playListTableView.delegate = self;
    self.playListTableView.dataSource = self;
    
    ///self.playListTableView.layer.cornerRadius = 15;
    //self.playListTableView.layer.masksToBounds = YES;
    
    self.secondView.layer.cornerRadius = 15;
    self.secondView.layer.masksToBounds = YES;
    self.secondView.layer.borderWidth = 2.0;
    self.secondView.layer.borderColor = [UIColor purpleColor].CGColor;
    
    [self addingAudioForIndex:currentPlayedAudio];//autoplay first video
}


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    // Release any retained subviews of the main view.
    [super viewWillDisappear:animated];
    [self stop:nil];
    
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
    [self incrementTableViewWithIndex:[NSIndexPath indexPathForRow:counter-1 inSection:0]];
}

- (void)rmvFromPlayListTableTransmitter:(Transmitter*)transmitter{
    
    
    if (transmitter.name != nil && ([self.transmitters indexOfObject:transmitter]< self.transmitters.count)) {
        NSLog(@"%@",transmitter.name);
        counter--;
        [self decrementTableViewWithIndex:[NSIndexPath indexPathForRow:[self.transmitters indexOfObject:transmitter] inSection:0]];
    }
    
}

-(void)addingAudioForIndex:(NSUInteger)index{
    
    //Higlight first cell
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.playListTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    //Add to Main Title
    self.mainTitle.text = [(Transmitter*)self.transmitters[index] name];
   
    NSError *error;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:tempAudioArray[index] ofType:@"mp3"];

    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] error:&error];
    self.audioPlayer.delegate = self;

    self.currentTimeSlider.minimumValue = 0.0f;
    self.currentTimeSlider.maximumValue = self.audioPlayer.duration;
    currentPlayedAudio = index;
    [self updateDisplay];
    [self play:self];
}

#pragma mark - Actions

- (IBAction)play:(id)sender {
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
}

- (IBAction)pause:(id)sender {
    [self.audioPlayer pause];
    [self stopTimer];
    [self updateDisplay];
}

- (IBAction)stop:(id)sender {
    [self.audioPlayer stop];
    [self stopTimer];
    self.audioPlayer.currentTime = 0;
    [self.audioPlayer prepareToPlay];
    [self updateDisplay];
}

- (IBAction)currentTimeSliderValueChanged:(id)sender
{
    if(self.timer)
        [self stopTimer];
    [self updateSliderLabels];
}

- (IBAction)currentTimeSliderTouchUpInside:(id)sender
{
    [self.audioPlayer stop];
    self.audioPlayer.currentTime = self.currentTimeSlider.value;
    [self.audioPlayer prepareToPlay];
    [self play:self];
}

#pragma mark - Timer
- (void)timerFired:(NSTimer*)timer
{
    [self updateDisplay];
}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
    [self updateDisplay];
}

#pragma mark - Display Update
- (void)updateDisplay
{
    NSTimeInterval currentTime = self.audioPlayer.currentTime;
    self.currentTimeSlider.value = currentTime;
    [self updateSliderLabels];
}

- (void)updateSliderLabels
{
    NSTimeInterval currentTime = self.currentTimeSlider.value;
    NSString* currentTimeString = [NSString stringWithFormat:@"%.02f", currentTime];
    
    self.elapsedTimeLabel.text =  currentTimeString;
    self.remainingTimeLabel.text = [NSString stringWithFormat:@"%.02f", self.audioPlayer.duration - currentTime];
}

#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"%s successfully=%@", __PRETTY_FUNCTION__, flag ? @"YES"  : @"NO");
    [self stopTimer];
    [self updateDisplay];
    
    if (currentPlayedAudio < counter-1) {
        [self addingAudioForIndex:++currentPlayedAudio];//Play next audio
    }
    else{
        currentPlayedAudio = 0; //start over
    }
    
   
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    NSLog(@"%s error=%@", __PRETTY_FUNCTION__, error);
    [self stopTimer];
    [self updateDisplay];
}

#pragma mark - animation Method

-(void)incrementTableViewWithIndex:(NSIndexPath*)indexToAdd{
    
    [self.playListTableView  beginUpdates];
    [self.playListTableView insertRowsAtIndexPaths:@[indexToAdd] withRowAnimation:UITableViewRowAnimationNone];
    [self.playListTableView  endUpdates];
    
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
