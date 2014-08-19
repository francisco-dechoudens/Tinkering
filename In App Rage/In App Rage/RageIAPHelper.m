//
//  RageIAPHelper.m
//  In App Rage
//
//  Created by Frankie on 8/18/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "RageIAPHelper.h"

@implementation RageIAPHelper

+ (RageIAPHelper *)sharedInstance {
    static dispatch_once_t once;
    static RageIAPHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:@"com.razeware.inappragedemo.drummerrager"
                                      ,@"com.razeware.inappragedemo.nightlyrage",
                                      @"com.razeware.inappragedemo.randomrageface",
                                      //The two new subscription identifiers you've just created
                                      @"com.razeware.inappragedemo.3monthlyrage",
                                      @"com.razeware.inappragedemo.6monthlyrage",
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

@end
