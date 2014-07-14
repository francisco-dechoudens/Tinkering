//
//  ViewController.m
//  GimbalGeofenceDemo
//
//  Created by Frankie on 7/14/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventLabel;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)enableGimbal:(id)sender {
    QLContextCoreConnector *connector = [QLContextCoreConnector new];
    
    [connector enableFromViewController:self success:^
     {
         NSLog(@"Gimbal enabled");
         self.statusLabel.text = @"Gimbal enabled";
     } failure:^(NSError *error) {
         NSLog(@"Failed to initialize gimbal %@", error);
         self.statusLabel.text = @"Failed to initialize gimbal";
     }];
}

- (IBAction)disableGimbal:(id)sender {
    QLContextCoreConnector *contextCoreConnector = [QLContextCoreConnector new];
    [contextCoreConnector deleteAllUserDataAndOnSuccess:^{
        NSLog(@"User data deletion SUCCESS");
        self.statusLabel.text = @"User data deletion SUCCESS";
    }
    failure:^(NSError *error) {
        NSLog(@"User data deletion FAILURE: %@", error );
        self.statusLabel.text = @"User data deletion FAILURE";
    }];
}

- (IBAction)checkStatus:(id)sender {
    QLContextCoreConnector *contextCoreConnector = [QLContextCoreConnector new];
    [contextCoreConnector checkStatusAndOnEnabled: ^(QLContextConnectorPermissions *contextConnectorPermissions) {
        NSLog(@"Already enabled");
        self.statusLabel.text = @"Already Enable";
    }
    disabled:^(NSError *error) {
        NSLog(@"Is not enabled");
        self.statusLabel.text = @"Is not enabled";
    }];
}

-(void)savePlaceEvent:(QLPlaceEvent *)placeEvent{
    
    switch (placeEvent.eventType)
    {
        case QLPlaceEventTypeAt:
            self.eventLabel.text = [NSString stringWithFormat:@"At %@", placeEvent.place.name];
            break;
        case QLPlaceEventTypeLeft:
            self.eventLabel.text = [NSString stringWithFormat:@"Left %@", placeEvent.place.name];
            break;
    }
}

@end
