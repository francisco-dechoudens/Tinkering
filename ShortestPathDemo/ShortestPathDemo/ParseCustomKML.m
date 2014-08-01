//
//  ParseCustomKML.m
//  KMLReaderDemo
//
//  Created by Frankie on 7/31/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "ParseCustomKML.h"
#import "Vertex.h"
#import "Placemark.h"

@implementation ParseCustomKML

- (id)initWithData:(NSData *)data{
    self = [super init];
    if (self) {
        NSError *error;
        // check for errors
        if (error) {
            NSLog(@"Error while parsing the document: %@", error);
            return nil;
        }
        _document = [SMXMLDocument documentWithData:data error:&error];
    }
    return self;
}

-(NSArray*)getVertexes{
    // Pull out the <Vertexes> node
    SMXMLElement *vertexes = [_document.firstChild childNamed:@"Vertexes"];
    
    // Array of objects that we are returning
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (SMXMLElement *vertex in [vertexes childrenNamed:@"vertex"]) {
        
        Vertex *aVertex = [[Vertex alloc]initWithIdentifier:[vertex childNamed:@"id"].value withCoordinates:[vertex childNamed:@"coordinates"].value];
        [result addObject:aVertex];
       
    }
    return result;
}

-(NSArray*)getPlacemarks{
    NSArray *placemarks = [_document.firstChild childrenNamed:@"Placemark"];//este me da el primero
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (SMXMLElement *placemark in placemarks) {
       
        Placemark *aPlacemark = [[Placemark alloc]initWithName:[placemark childNamed:@"name"].value
                                                    withWeight:[placemark childNamed:@"weight"].value
                                                       withSRC:[placemark childNamed:@"src"].value
                                                      withDest:[placemark childNamed:@"dest"].value
                                               withCoordinates:[[placemark childNamed:@"LineString"] childNamed:@"coordinates"].value];
        [result addObject:aPlacemark];
        
    }
    return result;
}

@end
