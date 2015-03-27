//
//  PlayerViewController.h
//  Christian Prayers
//
//  Created by Frankie on 3/23/15.
//  Copyright (c) 2015 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PlayerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *prayerTypeSubdivitionLabel;

@property (weak, nonatomic) PFObject *prayerTypeObject;

@end
