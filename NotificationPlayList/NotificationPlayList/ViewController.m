//
//  ViewController.m
//  NotificationPlayList
//
//  Created by Frankie on 7/22/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "ViewController.h"
#import "ItemAlertViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)button:(id)sender {
    ItemAlertViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemAlertViewControllerID"];
    
    [self presentViewController:vc animated:YES completion:nil];
    
}

@end
