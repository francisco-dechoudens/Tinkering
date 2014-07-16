//
//  VisitViewController.m
//  GimbalBeaconDemo
//
//  Created by Frankie on 7/15/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "VisitViewController.h"
#import <FYX/FYXSightingManager.h>

@interface VisitViewController ()
@property (weak, nonatomic) IBOutlet UILabel *currentRSSILabel;
@property (weak, nonatomic) IBOutlet UILabel *enterRSSI;
@property (weak, nonatomic) IBOutlet UILabel *leaveRSSI;
@property (weak, nonatomic) IBOutlet UILabel *timeToLeaveLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageVIew;

@end

@implementation VisitViewController{
    int seconds;
    NSTimer* timer;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.visitManager = [[FYXVisitManager alloc] init];
    self.visitManager.delegate = self;
    //[self.visitManager start]; default start
    
    int arrivalRSSI = -65;
    int departureRSSI = -70;
    int timeToLeave = 5;
    
    
    NSMutableDictionary *options = [NSMutableDictionary new];
    
    //Number of seconds before the absence of a beacon triggers the didDepart callback
    [options setObject:[NSNumber numberWithInt:timeToLeave] forKey:FYXVisitOptionDepartureIntervalInSecondsKey];
    
    //Smoothing of signal strengths using historic sliding window averaging
    [options setObject:[NSNumber numberWithInt:FYXSightingOptionSignalStrengthWindowNone] forKey:FYXSightingOptionSignalStrengthWindowKey];
    
    //An RSSI value of the beacon sighting that must be exceeded before a didArrive callback is triggered
    [options setObject:[NSNumber numberWithInt:arrivalRSSI] forKey:FYXVisitOptionArrivalRSSIKey];
    
    //If an RSSI value of the beacon sightings is less than this value and the departure interval is exceeded a didDepart callback is triggered
    [options setObject:[NSNumber numberWithInt:departureRSSI] forKey:FYXVisitOptionDepartureRSSIKey];
    
    [self.visitManager startWithOptions:options];
    
    self.enterRSSI.text = [NSString stringWithFormat:@"%d",arrivalRSSI];
    self.leaveRSSI.text = [NSString stringWithFormat:@"%d",departureRSSI];
    
    self.timeToLeaveLabel.text = [NSString stringWithFormat:@"%d seconds",timeToLeave];
    self.timeLabel.text = @"0";
}

- (void)resetTimer{
    [self stopTimer];
    timer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(updateLabel:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)stopTimer{
    seconds = 0;
    self.timeLabel.text = @"0";
    [timer invalidate];
}

-(void)updateLabel:(id)selector{
    self.timeLabel.text = [NSString stringWithFormat:@"%d",seconds++];
    self.currentRSSILabel.text = @"-∞";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didArrive:(FYXVisit *)visit;
{
    //NSLog(@"did Arrive, %@",visit.transmitter.name);
    
    self.imageVIew.image = [UIImage imageNamed:@"green"];
    self.timeLabel.text = [NSString stringWithFormat:@"%f",visit.dwellTime];
}

- (void)receivedSighting:(FYXVisit *)visit updateTime:(NSDate *)updateTime RSSI:(NSNumber *)RSSI;
{
    self.currentRSSILabel.text = [NSString stringWithFormat:@"%@",RSSI];
    /*
    NSLog(@"Sighting");
    NSLog(@"Receive Sighting");
    NSLog(@"name, %@",[visit.transmitter name]);
    NSLog(@"id, %@",[visit.transmitter identifier]);
    NSLog(@"owner, %@",[visit.transmitter ownerId]);
    NSLog(@"iconUrl, %@",[visit.transmitter iconUrl]);
    NSLog(@"battery, %@",[visit.transmitter battery]);
    NSLog(@"temperature, %@",[visit.transmitter temperature]);
    NSLog(@"time, %@",updateTime);
    NSLog(@"RSSI, %@",RSSI);
    */
    [self resetTimer];
}

- (void)didDepart:(FYXVisit *)visit;
{
    //NSLog(@"did Left, %@",visit.transmitter.name);
    [self stopTimer];
    self.imageVIew.image = [UIImage imageNamed:@"red"];
}

@end
