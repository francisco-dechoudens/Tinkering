//
//  ViewController.m
//  AsynchronousDemo
//
//  Created by Frankie on 7/28/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSMutableArray *bigArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	bigArray = [NSMutableArray arrayWithCapacity:5];  for (int i = 0; i < 5; i++) {
        [bigArray addObject:[NSString stringWithFormat:@"object-%i", i]];
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self updateBigArray:@"thread = A "];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self updateBigArray:@"thread = B"];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateBigArray:(NSString *)value {
    @synchronized (bigArray) {
        for (int j = 0; j < bigArray.count; j++) {
            NSString *currentObject = [bigArray objectAtIndex:j];
            [bigArray replaceObjectAtIndex:j withObject:[currentObject stringByAppendingFormat:@"-%@", value]];
            NSLog(@"%@", [bigArray objectAtIndex:j]);
        }
    }
}

- (void)updateBigArray2:(NSString *)value {
        for (int j = 0; j < bigArray.count; j++) {
            NSString *currentObject = [bigArray objectAtIndex:j];
            [bigArray replaceObjectAtIndex:j withObject:[currentObject stringByAppendingFormat:@"-%@", value]];
            NSLog(@"%@", [bigArray objectAtIndex:j]);
        }
}

@end
