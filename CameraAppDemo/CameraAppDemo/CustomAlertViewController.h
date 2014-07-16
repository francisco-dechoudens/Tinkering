//
//  CustomAlertViewController.h
//  Mappaleo
//
//  Created by Frankie on 7/15/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertViewController : UIViewController <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil image:(UIImageView*)imageView;
@end
