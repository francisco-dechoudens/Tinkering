//
//  Placemark.h
//  KMLReaderDemo
//
//  Created by Frankie on 7/31/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface Placemark : NSObject
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *weight;
@property (strong,nonatomic) NSString *src;
@property (strong,nonatomic) NSString *dest;
@property (nonatomic) NSMutableArray *coordinates;

- (id)initWithName:(NSString *)name withWeight:(NSString*)weight withSRC:(NSString*)src withDest:(NSString*)dest withCoordinates:(NSString*)coordinatesString;
@end
