//
//  AppDelegate.h
//  GimbalGeofenceDemo
//
//  Created by Frankie on 7/14/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ContextLocation/QLContextPlaceConnector.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,QLContextPlaceConnectorDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) QLContextPlaceConnector *placeConnector;
@end
