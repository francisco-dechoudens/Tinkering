//
//  PESGraphEdge+Coordinates.m
//  ShortestPathDemo
//
//  Created by Frankie on 8/1/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "PESGraphEdge+Coordinates.h"

@implementation PESGraphEdge_Coordinates
@synthesize coordinatesArray;

#pragma mark -
#pragma mark Class Methods

+ (PESGraphEdge *)edgeWithName:(NSString *)aName andWeight:(NSNumber *)aNumber andCoordinatesArray:(NSMutableArray*)coordinatesArray{
    PESGraphEdge_Coordinates *anEdge = [[PESGraphEdge_Coordinates alloc] init];
    
    anEdge.weight = aNumber;
    anEdge.name = aName;
    anEdge.coordinatesArray = coordinatesArray;
    
    return anEdge;
}

@end
