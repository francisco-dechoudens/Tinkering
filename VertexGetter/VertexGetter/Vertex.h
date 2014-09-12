//
//  Vertex.h
//  KMLReaderDemo
//
//  Created by Frankie on 7/31/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Vertex : NSObject
@property (strong,nonatomic) NSString *identifier;
@property (nonatomic) CLLocationCoordinate2D coordinate;
- (id)initWithIdentifier:(NSString *)identifier withCoordinates:(NSString*)coordinates;
@end
