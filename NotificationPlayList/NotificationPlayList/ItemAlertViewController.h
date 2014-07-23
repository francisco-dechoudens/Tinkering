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

@interface ItemAlertViewController : UIViewController<UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *currentNumberVideo;
@property (weak, nonatomic) IBOutlet UILabel *totalNumberVideo;

@end
