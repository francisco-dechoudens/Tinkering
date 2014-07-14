//
//  ViewController.h
//  GimbalGeofenceDemo
//
//  Created by Frankie on 7/14/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ContextCore/QLContextCoreConnector.h>
#import <ContextLocation/QLPlaceEvent.h>
#import <ContextLocation/QLPlace.h>

@interface ViewController : UIViewController
-(void)savePlaceEvent:(QLPlaceEvent *)placeEvent;
@end
