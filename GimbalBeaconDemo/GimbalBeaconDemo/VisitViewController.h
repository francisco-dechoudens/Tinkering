//
//  VisitViewController.h
//  GimbalBeaconDemo
//
//  Created by Frankie on 7/15/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FYX/FYXVisitManager.h>

@interface VisitViewController : UIViewController <FYXVisitDelegate>
@property (nonatomic) FYXVisitManager *visitManager;
@end
