//
//  SecondViewController.m
//  In App Rage
//
//  Created by Frankie on 8/19/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)refresh {
    int currentValue = [[NSUserDefaults standardUserDefaults]
                        integerForKey:@"com.razeware.inappragedemo.randomrageface"];
    self.label.text = [NSString stringWithFormat:@"Times Remaining: %d", currentValue];
}

- (void)viewWillAppear:(BOOL)animated {
    [self refresh];
}

- (IBAction)buttonTapped:(id)sender {
    
    int currentValue = [[NSUserDefaults standardUserDefaults]
                        integerForKey:@"com.razeware.inappragedemo.randomrageface"];
    if (currentValue <= 0) return;
    
    currentValue--;
    [[NSUserDefaults standardUserDefaults] setInteger:currentValue
                                               forKey:@"com.razeware.inappragedemo.randomrageface"];
    [self refresh];
    
    int randomIdx = (arc4random() % 4) + 1;
    NSString * randomName = [NSString stringWithFormat:@"random%d.png", randomIdx];
    self.imageView.image = [UIImage imageNamed:randomName];
}

@end
