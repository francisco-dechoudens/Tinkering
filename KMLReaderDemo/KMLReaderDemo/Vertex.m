//
//  Vertex.m
//  KMLReaderDemo
//
//  Created by Frankie on 7/31/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "Vertex.h"

@implementation Vertex

- (id)initWithIdentifier:(NSString *)identifier withCoordinates:(NSString*)coordinatesString{
    self = [super init];
    if (self) {
        self.identifier = identifier;

        NSArray *coordArray = [coordinatesString componentsSeparatedByString: @" "];
        NSArray *coord = [coordArray.firstObject componentsSeparatedByString: @","];
            
        CLLocationDegrees longitude = [(NSString*)[coord objectAtIndex:0] floatValue];
        CLLocationDegrees latitude = [(NSString*)[coord objectAtIndex:1] floatValue];
        //CLLocationDegrees altitude = [(NSString*)[coord objectAtIndex:2] floatValue];
            
        self.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    }
    return self;
}

@end
