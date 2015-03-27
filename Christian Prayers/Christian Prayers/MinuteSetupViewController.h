//
//  MinuteSetupViewController.h
//  Christian Prayers
//
//  Created by Frankie on 3/23/15.
//  Copyright (c) 2015 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface MinuteSetupViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *circleView;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UILabel *numberMinuteLabel;
@property (weak, nonatomic) PFObject *prayerTypeObject;
@end
