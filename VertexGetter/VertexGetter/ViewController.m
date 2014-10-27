//
//  ViewController.m
//  VertexGetter
//
//  Created by Frankie on 9/3/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "ViewController.h"
#import "ParseCustomKML.h"
#import <MapKit/MapKit.h>
#import "PESGraph.h"
#import "PESGraphNode.h"
#import "PESGraphEdge+Coordinates.h"
#import "PESGraphRoute.h"
#import "PESGraphRouteStep.h"
#import "ParseCustomKML.h"
#import "Vertex.h"
#import "Placemark.h"

@interface ViewController ()<CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    CLLocation* userLocation;
}
@property (nonatomic, strong) NSArray* vertixesArr;
@property (nonatomic, strong)NSArray* placemarksArr;
@property (nonatomic, strong)NSMutableDictionary *nodeDictionary;
@property (nonatomic, strong)PESGraph *graph;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.spinner.hidden = YES;
    [self createGraph];
	// Do any additional setup after loading the view, typically from a nib.
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestAlwaysAuthorization];
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    userLocation = newLocation;
    [locationManager stopUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)searchVertexButton:(id)sender {
    [locationManager startUpdatingLocation];
    self.spinner.hidden = NO;
    [self.spinner startAnimating];
    [NSTimer scheduledTimerWithTimeInterval:2
                                     target:self
                                   selector:@selector(addLineForVertex)
                                   userInfo:nil
                                    repeats:NO];
}

-(void)createGraph{
    // create a new SMXMLDocument with the contents of sample.xml
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"MarquezaDKML" ofType:@"kml"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    ParseCustomKML *kml = [[ParseCustomKML alloc]initWithData:data];
    _vertixesArr = [kml getVertexes];
    _placemarksArr = [kml getPlacemarks];
    
    _nodeDictionary = [NSMutableDictionary new];
    _graph = [[PESGraph alloc] init];
}

- (void)addLineForVertex{
    
    //For get the nearest node to the user.
    CLLocationDistance last = 0.0;
    BOOL firstTime = YES;
    NSString *nearVertexID;
    //Convert Vertex to node
    for (Vertex* vertex in _vertixesArr) {
        PESGraphNode *node = [PESGraphNode nodeWithIdentifier:vertex.identifier];
        NSMutableDictionary *additionalData = [[NSMutableDictionary alloc] init];
        CLLocation *coordinate = [[CLLocation alloc] initWithLatitude:vertex.coordinate.latitude longitude:vertex.coordinate.longitude];
        [additionalData setObject:coordinate forKey:@"coordinate"];
        node.additionalData = additionalData;
        [_nodeDictionary setObject:node forKey:node.identifier];
        
        CLLocation* vertexLocation = [[CLLocation alloc]initWithLatitude:vertex.coordinate.latitude longitude:vertex.coordinate.longitude];
        if (firstTime) {
            last = [userLocation distanceFromLocation:vertexLocation];
            nearVertexID = vertex.identifier;
            firstTime = NO;
        }
        else if(last>[userLocation distanceFromLocation:vertexLocation]){
            last = [userLocation distanceFromLocation:vertexLocation];
            nearVertexID = vertex.identifier;
        }
    }
    
    int pointsCount = 0;
    //Create Edges with placemark and vertex and connect them to a graph
    for (Placemark* placemark in _placemarksArr) {
        
        PESGraphNode *srcNode = [_nodeDictionary objectForKey:placemark.src];
        PESGraphNode *destNode = [_nodeDictionary objectForKey:placemark.dest];
        NSNumber *edgeWeight = @(placemark.weight.floatValue);
        pointsCount += placemark.coordinates.count;
        [_graph addBiDirectionalEdge:[PESGraphEdge_Coordinates edgeWithName:placemark.name andWeight:edgeWeight andCoordinatesArray:placemark.coordinates]fromNode:srcNode toNode:destNode];
    }
    
    self.vertexLabel.text = nearVertexID;
    self.spinner.hidden = YES;
    [self.spinner stopAnimating];
    //PESGraphNode *srcNode = [_nodeDictionary objectForKey:nearVertexID];//Aqui es el del usuario
}
@end
