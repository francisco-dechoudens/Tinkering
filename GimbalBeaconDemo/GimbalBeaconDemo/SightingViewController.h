//
//  SightingViewController.h
//  GimbalBeaconDemo
//
//  Created by Frankie on 7/15/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FYX/FYXSightingManager.h>

@interface SightingViewController : UIViewController <FYXSightingDelegate>
@property (nonatomic) FYXSightingManager *sightingManager;
@end
