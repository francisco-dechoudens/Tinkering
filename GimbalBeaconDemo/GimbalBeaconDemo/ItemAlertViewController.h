//
//  ItemAlertViewController.h
//  Mappaleo
//
//  Created by Frankie on 7/18/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "Transmitter.h"

@interface ItemAlertViewController : UIViewController<UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@property (strong, nonatomic) NSMutableArray* transmitters;

- (void)addToPlayListTable;
- (void)rmvFromPlayListTableTransmitter:(Transmitter*)transmitter;

@end
