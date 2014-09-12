//
//  PESGraphEdge+Coordinates.h
//  ShortestPathDemo
//
//  Created by Frankie on 8/1/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "PESGraphEdge.h"

@interface PESGraphEdge_Coordinates : PESGraphEdge{
    
    NSMutableArray* coordinatesArray;
}

@property (nonatomic, strong) NSMutableArray *coordinatesArray;

+ (PESGraphEdge *)edgeWithName:(NSString *)aName andWeight:(NSNumber *)aNumber andCoordinatesArray:(NSMutableArray*)coordinatesArray;


@end
