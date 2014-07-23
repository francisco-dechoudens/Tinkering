//
//  ViewController.m
//  VideoPlayDemo
//
//  Created by Frankie on 7/18/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString * aString = @"http://files.parsetfss.com/b5ac615e-e131-4fe5-97d6-acd2d07f1d70/tfss-708f7477-55d0-42d2-8316-2af37daa3b67-Little-Girl-and-Baby-Gorilla-Become-Friends-YouTube.mp4";
    
    self.videoURL = [NSURL URLWithString:[aString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    self.videoController = [[MPMoviePlayerController alloc] init];
    [self.videoController setContentURL:self.videoURL];
    [self.videoController.view setFrame:CGRectMake (0, 0, 320, 460)];
    [self.view addSubview:self.videoController.view];
    
    [self.videoController play];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}


@end
