//
//  SightingViewController.m
//  GimbalBeaconDemo
//
//  Created by Frankie on 7/15/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "SightingViewController.h"
#import <FYX/FYXTransmitter.h>

@interface SightingViewController ()

@end

@implementation SightingViewController

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
    self.sightingManager = [[FYXSightingManager alloc] init];
    self.sightingManager.delegate = self;
    [self.sightingManager scan]; //Scan default setting
    
    //NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    //[options setObject:[NSNumber numberWithInt:FYXSightingOptionSignalStrengthWindowLarge]
                //forKey:FYXSightingOptionSignalStrengthWindowKey];
    
    //[self.sightingManager scanWithOptions:options];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)scanButton:(id)sender {
    printf("\n");
    [self.sightingManager scan];
}

-(void)didReceiveSighting:(FYXTransmitter *)transmitter time:(NSDate *)time RSSI:(NSNumber *)RSSI{
    NSLog(@"Receive Sighting");
    NSLog(@"name, %@",[transmitter name]);
    NSLog(@"id, %@",[transmitter identifier]);
    NSLog(@"owner, %@",[transmitter ownerId]);
    NSLog(@"iconUrl, %@",[transmitter iconUrl]);
    NSLog(@"battery, %@",[transmitter battery]);
    NSLog(@"temperature, %@",[transmitter temperature]);
    NSLog(@"time, %@",time);
    NSLog(@"RSSI, %@",RSSI);
    [self.sightingManager stopScan];
}

@end
