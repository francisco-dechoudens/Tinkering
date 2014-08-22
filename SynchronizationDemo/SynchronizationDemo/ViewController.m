//
//  ViewController.m
//  SynchronizationDemo
//
//  Created by Frankie on 8/22/14.
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
    
    bigArray = [NSMutableArray new];
    NSLog(@"Initial Array Values");
    for (int i = 0; i < 5; i++) {
        NSNumber *integer = [NSNumber numberWithInt:0];
         [bigArray addObject:integer];
         NSLog(@"Array[%d] = %@",i,bigArray[i]);
    }
    NSLog(@"Modify Array Values");
    
    NSString *foo = @"foo";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self updateBigArray:foo];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self updateBigArrayFoo2:@"foo2"];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateBigArray:(NSString *)value {
     @synchronized (bigArray) {
        for (int j = 0; j < 5; j++) {
            NSNumber *integer = [NSNumber numberWithInt:j+1];
            [bigArray replaceObjectAtIndex:j withObject:integer];
            NSLog(@"Array[%d] = %@ modify by %@",j,bigArray[j],value);
        }
     }
}

- (void)updateBigArrayFoo2:(NSString *)value {
    @synchronized (bigArray) {
    for (int j = 0; j < 5; j++) {
        NSNumber *integer = [NSNumber numberWithInt:j+50];
        [bigArray replaceObjectAtIndex:j withObject:integer];
        NSLog(@"Array[%d] = %@ modify by %@",j,bigArray[j],value);
    }
    }
}

@end
