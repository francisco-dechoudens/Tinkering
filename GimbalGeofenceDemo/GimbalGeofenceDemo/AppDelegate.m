//
//  AppDelegate.m
//  GimbalGeofenceDemo
//
//  Created by Frankie on 7/14/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <ContextCore/QLContextCoreConnector.h>
#import <ContextLocation/QLPlaceEvent.h>
#import <ContextLocation/QLPlace.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /*
     Enable Context Core Connector
     The QLContextCoreConnector must be enabled prior to using any other Gimbal features.
     All calls to the API will return failures with a disabled status message until this step is complete.
    
    QLContextCoreConnector *connector = [QLContextCoreConnector new];
    
    [connector enableFromViewController:self.window.rootViewController success:^
     {
         NSLog(@"Gimbal enabled");
     } failure:^(NSError *error) {
         NSLog(@"Failed to initialize gimbal %@", error);
     }];
     */
    self.placeConnector = [[QLContextPlaceConnector alloc] init];
    self.placeConnector.delegate = self;

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



- (void)didGetPlaceEvent:(QLPlaceEvent *)placeEvent
{
    
    //QLPlaceTypeOrganization refers to places created in Context Console and applies to all of your users.
    //A QLPlaceTypePrivate is created locally on the phone and only applies to a single user.
    NSLog(@"Place Type %u", [placeEvent placeType]);
    
    //The QLPlace object associated with the event
    NSLog(@"Place %@", [placeEvent place].name);
    
    //QLPlaceEventTypeAt means that the user has arrived at the place.
    //QLPlaceEventTypeLeft means that the user has just left the place.
    NSLog(@"Event %u", [placeEvent eventType]);
    
    //The time of the event in milliseconds since 1970 (see System.currentTimeMillis()).
    NSLog(@"Time %@", [placeEvent time]);
    
    ViewController *vc = (ViewController*)self.window.rootViewController;
    [vc savePlaceEvent:placeEvent];
    
}
      

- (BOOL)shouldMonitorPlace: (QLPlace *)place{
    // Return YES if place needs to be monitored
    // Return NO if place does not need to be monitored
    
    //Test - Just monitor Caguas
    if ([place.name isEqualToString:@"test2"]) {
        return YES;
    }
    else{
        return NO;
    }
}

@end
