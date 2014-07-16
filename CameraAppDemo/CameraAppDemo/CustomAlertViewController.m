//
//  CustomAlertViewController.m
//  Mappaleo
//
//  Created by Frankie on 7/15/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "CustomAlertViewController.h"

@interface CustomAlertViewController ()

@end

@implementation CustomAlertViewController{
    UIImageView * myImageView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil image:(UIImageView*)imageView
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //sets two UIViewController properties
        self.modalPresentationStyle = UIModalPresentationCustom; //we’re going to supply a custom transition animation
        self.transitioningDelegate = self; //reveal where the custom transition animation is to come from
        myImageView = imageView;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//pointing to an object that will provide the actual custom PRESENT transition animation
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:
(UIViewController *)presented
                                                                 presentingController:(UIViewController *)presenting
                                                                     sourceController:(UIViewController *)source
{
    return self;
}
//pointing to an object that will provide the actual custom DISMISS transition animation
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}

//a method that reveals the duration of the animation:
-(NSTimeInterval)transitionDuration:
(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (IBAction)cancelButton:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

//the actual custom transition animation
-(void)animateTransition:
(id<UIViewControllerContextTransitioning>)transitionContext {
    
    //The two view controllers involved in the transition
    UIViewController* vc1 =
    [transitionContext viewControllerForKey:
     UITransitionContextFromViewControllerKey];
    
    UIViewController* vc2 =
    [transitionContext viewControllerForKey:
     UITransitionContextToViewControllerKey];
    
    //The special container view inside which the views of those two view controllers will appear.
    UIView* con = [transitionContext containerView];
    
    UIView* v1 = vc1.view;
    UIView* v2 = vc2.view;
    
    if (vc2 == self) { // presenting
        [con addSubview:v2];
        v2.frame = v1.frame; //“shadow view” - its frame will be the same as the frame of the original view behind it
        self.backgroundView.transform = CGAffineTransformTranslate(self.backgroundView.transform, 0, 140.0); // for animate our view from large to normal(Scaling factor by which to scale 1.6)
        v2.alpha = 1; //we will animate our view from invisible to visible
        v1.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
        [UIView animateWithDuration:0.5 animations:^{
            v2.alpha = 1;
            self.backgroundView.transform = CGAffineTransformIdentity; //Checks whether an affine transform is the identity transform
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
    else { // dismissing
        [UIView animateWithDuration:0.5 animations:^{
            self.backgroundView.transform = CGAffineTransformTranslate(self.backgroundView.transform, 0, 200.0);//(Scaling factor by which to scale 0.5)
            v1.alpha = 1;
        } completion:^(BOOL finished) {
            v2.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
            [transitionContext completeTransition:YES];
        }];
    }
}
- (IBAction)takeAShot:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    else{
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:NULL];
    }
    
    
    
}
- (IBAction)selectAPhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    myImageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}



@end
