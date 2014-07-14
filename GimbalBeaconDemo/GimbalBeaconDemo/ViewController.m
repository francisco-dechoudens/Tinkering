//
//  ViewController.m
//  GimbalBeaconDemo
//
//  Created by Frankie on 7/14/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (nonatomic) FYXVisitManager *visitManager;
@property (weak, nonatomic) IBOutlet UILabel *didLabel;
@property (weak, nonatomic) IBOutlet UILabel *sightingLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrivalRSSILabel;
@property (weak, nonatomic) IBOutlet UILabel *departureRSSILabel;
@property (weak, nonatomic) IBOutlet UILabel *currentRSSILabel;
@end

@implementation ViewController{
    int count;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.visitManager = [FYXVisitManager new];
    self.visitManager.delegate = self;
   
    NSMutableDictionary *options = [NSMutableDictionary new];
    [options setObject:[NSNumber numberWithInt:5] forKey:FYXVisitOptionDepartureIntervalInSecondsKey];
    
    int arrivalRSSI = -70;
    int departureRSSI = -85;
    
    self.arrivalRSSILabel.text = [NSString stringWithFormat:@"%d",arrivalRSSI];
    self.departureRSSILabel.text = [NSString stringWithFormat:@"%d",departureRSSI];
    
    [options setObject:[NSNumber numberWithInt:arrivalRSSI] forKey:FYXVisitOptionArrivalRSSIKey];
    [options setObject:[NSNumber numberWithInt:departureRSSI] forKey:FYXVisitOptionDepartureRSSIKey];
    [self.visitManager startWithOptions:options];}     

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didArrive:(FYXVisit *)visit;
{
    // this will be invoked when an authorized transmitter is sighted for the first time
    NSString* message = [NSString stringWithFormat:@"I arrived at a Gimbal Beacon!!! %@", visit.transmitter.name];
    self.didLabel.text = message;
    count = 0;
}

- (void)receivedSighting:(FYXVisit *)visit updateTime:(NSDate *)updateTime RSSI:(NSNumber *)RSSI;
{
    // this will be invoked when an authorized transmitter is sighted during an on-going visit
  
    NSString* message = [NSString stringWithFormat:@"I received a sighting!!! %@ count %d", visit.transmitter.name,++count];
    
    //NSLog(@"%@",visit.transmitter.battery);//batery level
    //NSLog(@"%@",visit.transmitter.temperature);//Beacon temperature
    //NSLog(@"%@",RSSI);
    self.currentRSSILabel.text = [NSString stringWithFormat:@"%@",RSSI];
    self.sightingLabel.text = message;
}

- (void)didDepart:(FYXVisit *)visit;
{
    // this will be invoked when an authorized transmitter has not been sighted for some time
    NSString* message = [NSString stringWithFormat:@"I left the proximity of a Gimbal Beacon!!!! %@", visit.transmitter.name];
    self.didLabel.text = message;
    
    NSString* message2 = [NSString stringWithFormat:@"%f", visit.dwellTime];
    self.timeLabel.text = message2;
}

@end
