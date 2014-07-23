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
