//
//  ViewController.m
//  ShortestPathDemo
//
//  Created by Frankie on 8/1/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "ViewController.h"
#import "PESGraph.h"
#import "PESGraphNode.h"
#import "PESGraphEdge+Coordinates.h"
#import "PESGraphRoute.h"
#import "PESGraphRouteStep.h"
#import "ParseCustomKML.h"
#import "Vertex.h"
#import "Placemark.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// create a new SMXMLDocument with the contents of sample.xml
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"kml"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    ParseCustomKML *kml = [[ParseCustomKML alloc]initWithData:data];
    NSArray* vertixesArr = [kml getVertexes];
    NSArray* placemarksArr = [kml getPlacemarks];
    
    NSMutableDictionary *nodeDictionary = [NSMutableDictionary new];
    PESGraph *graph = [[PESGraph alloc] init];
    
    //Convert Vertex to node
    for (Vertex* vertex in vertixesArr) {
        PESGraphNode *node = [PESGraphNode nodeWithIdentifier:vertex.identifier];
        NSMutableDictionary *additionalData = [[NSMutableDictionary alloc] init];
        CLLocation *coordinate = [[CLLocation alloc] initWithLatitude:vertex.coordinate.latitude longitude:vertex.coordinate.longitude];
        [additionalData setObject:coordinate forKey:@"coordinate"];
        node.additionalData = additionalData;
        [nodeDictionary setObject:node forKey:node.identifier];
    }
    
    //Create Edges with placemark and vertex and connect them to a graph
    for (Placemark* placemark in placemarksArr) {
        
        PESGraphNode *srcNode = [nodeDictionary objectForKey:placemark.src];
        PESGraphNode *destNode = [nodeDictionary objectForKey:placemark.dest];
        NSNumber *edgeWeight = @(placemark.weight.floatValue);
        
        [graph addBiDirectionalEdge:[PESGraphEdge_Coordinates edgeWithName:placemark.name andWeight:edgeWeight andCoordinatesArray:placemark.coordinates]fromNode:srcNode toNode:destNode];
    }
    /*
    for (NSString* key in nodeDictionary) {
        PESGraphNode *node = [nodeDictionary objectForKey:key];
        NSLog(@"%@",node.identifier);
        CLLocation *aCoordinate = (CLLocation*)node.additionalData[@"coordinate"];
        NSLog(@"{%f,%f}",aCoordinate.coordinate.latitude,aCoordinate.coordinate.longitude);
    }*/
    
    PESGraphNode *srcNode = [nodeDictionary objectForKey:@"0"];
    PESGraphNode *destNode = [nodeDictionary objectForKey:@"Cactus"];
    PESGraphRoute *route = [graph shortestRouteFromNode:srcNode toNode:destNode];
   
    NSArray *steps = route.steps;
    
    for (PESGraphRouteStep *step in steps) {
        NSLog(@"%@",step.node.identifier);
        NSLog(@"%@",step.edge.name);
        PESGraphEdge_Coordinates *edge = step.edge;
        for (CLLocation *location in edge.coordinatesArray) {
             NSLog(@"{%f,%f}",location.coordinate.latitude,location.coordinate.longitude);
        }
    }
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
