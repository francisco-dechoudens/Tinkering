//
//  Placemark.m
//  KMLReaderDemo
//
//  Created by Frankie on 7/31/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "Placemark.h"

@implementation Placemark
- (id)initWithName:(NSString *)name withWeight:(NSString*)weight withSRC:(NSString*)src withDest:(NSString*)dest withCoordinates:(NSString*)coordinatesString{
    self = [super init];
    if (self) {
        self.name = name;
        self.weight = weight;
        self.src = src;
        self.dest = dest;
        self.coordinates = [NSMutableArray new];
        
        NSArray *coordArray = [coordinatesString componentsSeparatedByString: @" "];
        for (NSString* coordString  in coordArray) {
            NSArray *coord = [coordString componentsSeparatedByString: @","];
            
            CLLocationDegrees longitude = [(NSString*)[coord objectAtIndex:0] floatValue];
            CLLocationDegrees latitude = [(NSString*)[coord objectAtIndex:1] floatValue];
            //CLLocationDegrees altitude = [(NSString*)[coord objectAtIndex:2] floatValue];
            
            CLLocation *coordinate = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
            
            [self.coordinates addObject:coordinate];
        }
        

    }
    return self;
}
@end
