//
//  ViewController.m
//  X-Wing AI
//
//  Created by Frankie on 11/6/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)northButton:(id)sender {
    NSLog(@"at 12 o'clock");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enemy at: 12 o'clock" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    // optional - add more buttons:
    [alert addButtonWithTitle:@"Enemy is Closing"];
    [alert addButtonWithTitle:@"Enemy is Retreating"];
    [alert addButtonWithTitle:@"Enemy is Out-of-Range"];

    [alert show];
}
- (IBAction)eastButton:(id)sender {
      NSLog(@"at 3 o'clock");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enemy at: 3 o'clock" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    // optional - add more buttons:
    [alert addButtonWithTitle:@"Enemy is Closing"];
    [alert addButtonWithTitle:@"Enemy is Retreating"];
    [alert addButtonWithTitle:@"Enemy is Out-of-Range"];

    [alert show];
}
- (IBAction)southButton:(id)sender {
      NSLog(@"at 6 o'clock");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enemy at: 6 o'clock" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    // optional - add more buttons:
    [alert addButtonWithTitle:@"Enemy is Closing"];
    [alert addButtonWithTitle:@"Enemy is Retreating"];
    [alert addButtonWithTitle:@"Enemy is Out-of-Range"];

    [alert show];
}
- (IBAction)westButton:(id)sender {
      NSLog(@"at 9 o'clock");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enemy at: 9 o'clock" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    // optional - add more buttons:
    [alert addButtonWithTitle:@"Enemy is Closing"];
    [alert addButtonWithTitle:@"Enemy is Retreating"];
    [alert addButtonWithTitle:@"Enemy is Out-of-Range"];

    [alert show];
}
- (IBAction)northEastButton:(id)sender {
      NSLog(@"at 1-2 o'clock");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enemy at: 1-2 o'clock" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    // optional - add more buttons:
    [alert addButtonWithTitle:@"Enemy is Closing"];
    [alert addButtonWithTitle:@"Enemy is Retreating"];
    [alert addButtonWithTitle:@"Enemy is Out-of-Range"];
    
    [alert show];
}
- (IBAction)southEastButton:(id)sender {
      NSLog(@"at 4-5 o'clock");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enemy at: 4-5 o'clock" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    // optional - add more buttons:
    [alert addButtonWithTitle:@"Enemy is Closing"];
    [alert addButtonWithTitle:@"Enemy is Retreating"];
    [alert addButtonWithTitle:@"Enemy is Out-of-Range"];
    
    [alert show];
}
- (IBAction)northWestButton:(id)sender {
      NSLog(@"at 10-11 o'clock");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enemy at: 10-11 o'clock" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    // optional - add more buttons:
    [alert addButtonWithTitle:@"Enemy is Closing"];
    [alert addButtonWithTitle:@"Enemy is Retreating"];
    [alert addButtonWithTitle:@"Enemy is Out-of-Range"];

    [alert show];
}
- (IBAction)southWestButton:(id)sender {
      NSLog(@"at 7-8 o'clock");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enemy at: 7-8 o'clock" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    // optional - add more buttons:
    [alert addButtonWithTitle:@"Enemy is Closing"];
    [alert addButtonWithTitle:@"Enemy is Retreating"];
    [alert addButtonWithTitle:@"Enemy is Out-of-Range"];

    [alert show];
}
@end
