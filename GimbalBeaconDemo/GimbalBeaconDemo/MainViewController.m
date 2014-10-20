//
//  MainViewController.m
//  GimbalBeaconDemo
//
//  Created by Frankie on 10/16/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "MainViewController.h"
#import "ItemAlertViewController.h"
#import "Transmitter.h"
#import "SightingsTableViewCell.h"

@interface MainViewController ()
@property (nonatomic,strong) FYXVisitManager *visitManager;
@property NSMutableArray *transmitters;
@property (weak, nonatomic) IBOutlet UIView *loadingView;

@end

@implementation MainViewController{
    bool canAddToPlaylist;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.transmitters = [NSMutableArray new];
    
    self.visitManager = [FYXVisitManager new];
    self.visitManager.delegate = self;
    
    NSMutableDictionary *options = [NSMutableDictionary new];
    [options setObject:[NSNumber numberWithInt:5] forKey:FYXVisitOptionDepartureIntervalInSecondsKey];
    
    int arrivalRSSI = -75;
    int departureRSSI = -85;
    
    [options setObject:[NSNumber numberWithInt:arrivalRSSI] forKey:FYXVisitOptionArrivalRSSIKey];
    [options setObject:[NSNumber numberWithInt:departureRSSI] forKey:FYXVisitOptionDepartureRSSIKey];
    [self.visitManager startWithOptions:options];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didArrive:(FYXVisit *)visit;
{
    NSLog(@"############## didArrive");
   //NSLog(@"############## didArrive: %@", visit);
}

- (void)receivedSighting:(FYXVisit *)visit updateTime:(NSDate *)updateTime RSSI:(NSNumber *)RSSI;
{
    //Para ver si ya estaba creado
    Transmitter *transmitter = [[self.transmitters filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"identifier == %@", visit.transmitter.identifier]] firstObject];
    
    //
   
    NSArray *waitingTransmitters = [self.transmitters filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"isUsed == NO"]];
                        
    //
    if (transmitter == nil)
    {
        
        //Transmitter creator
        transmitter = [Transmitter new];
        transmitter.identifier = visit.transmitter.identifier;
        transmitter.name = visit.transmitter.name ? visit.transmitter.name : visit.transmitter.identifier;
        transmitter.lastSighted = [NSDate dateWithTimeIntervalSince1970:0];
        transmitter.rssi = [NSNumber numberWithInt:-100];
        transmitter.previousRSSI = transmitter.rssi;
        transmitter.batteryLevel = 0;
        transmitter.temperature = 0;
        
        
        [self.transmitters addObject:transmitter];
        
        if ([self.transmitters count] == 1)
        {
            transmitter.isUsed = YES;
            //The first create the main alert
             NSLog(@"start creating Cell:%@",transmitter.name);
            ItemAlertViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemAlertViewControllerID"];
            vc.transmitters = [NSMutableArray new];
            [vc.transmitters addObject:transmitter];
            [self presentViewController:vc animated:YES completion:^{
                canAddToPlaylist = YES;
                NSLog(@"finish creating Cell:%@",transmitter.name);
            }];
        }
    }
    else  if([waitingTransmitters count] >= 1 && canAddToPlaylist) {
        NSLog(@"start updating Cell:%@",transmitter.name);
        
        
        Transmitter *waitingtransmitter = waitingTransmitters.firstObject;
        waitingtransmitter.isUsed = YES;
        [self.transmitters replaceObjectAtIndex:[self.transmitters indexOfObject:waitingtransmitter] withObject:waitingtransmitter];
        
        ItemAlertViewController *vc = (ItemAlertViewController*)self.presentedViewController;
        [vc.transmitters addObject:waitingtransmitter];
        [vc addToPlayListTable];
        
        
    }

    
    transmitter.lastSighted = updateTime;
    
}

- (void)didDepart:(FYXVisit *)visit;
{
    
    Transmitter *transmitter = [[self.transmitters filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"identifier == %@", visit.transmitter.identifier]] firstObject];
    
    NSLog(@"############## didDepart: %@", visit.transmitter.name);
    NSLog(@"############## remove: %@", transmitter.name);
    
    [self.transmitters removeObject:transmitter];
    if ([self.presentedViewController isKindOfClass:[ItemAlertViewController class]] && (self.transmitters.count >= 1)) {
        
        ItemAlertViewController *vc = (ItemAlertViewController*)self.presentedViewController;
        [vc rmvFromPlayListTableTransmitter:transmitter];
    }
    else{
        [self.transmitters removeAllObjects];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
