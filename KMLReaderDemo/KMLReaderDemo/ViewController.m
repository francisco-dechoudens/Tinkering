//
//  ViewController.m
//  KMLReaderDemo
//
//  Created by Frankie on 7/31/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "ViewController.h"
#import "SMXMLDocument.h"
#import "Vertex.h"
#import "Placemark.h"
#import "ParseCustomKML.h"

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
    
    for (Vertex* vertex in vertixesArr) {
        NSLog(@"%@",vertex.identifier);
        NSLog(@"{%f,%f}",vertex.coordinate.latitude,vertex.coordinate.longitude);
    }
    
    for (Placemark* placemark in placemarksArr) {
        NSLog(@"%@",placemark.name);
        NSLog(@"%@",placemark.weight);
        NSLog(@"%@",placemark.src);
        NSLog(@"%@",placemark.dest);
        for (CLLocation *location in placemark.coordinates) {
            NSLog(@"{%f,%f}",location.coordinate.latitude,location.coordinate.longitude);
        }
        
        
    }
    

    /*
	NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"kml"];
    KMLRoot *kml = [KMLParser parseKMLAtPath:path];
    
    NSArray *arrPoint = [self geometries:kml.placemarks];
    //self.kml.geometries
    //to view each placemark name
    int i = 0;
    for (id kmlObject in arrPoint) {
        if ([kmlObject isKindOfClass:[KMLPoint class]]) {
            NSLog(@"%@", [kml.placemarks[i] name]);
            NSLog(@"%@", [kml.placemarks[i++] descriptionValue]);
            float lon = [[(KMLPoint *)kmlObject coordinate] longitude];
            float lat = [[(KMLPoint *)kmlObject coordinate] latitude];
            NSLog(@"{%f,%f}",lat,lon);
        }
        else if ([kmlObject isKindOfClass:[KMLLineString class]]) {
            NSLog(@"name:%@", [kml.placemarks[i] name]);
            NSLog(@"description:%@", [kml.placemarks[i] descriptionValue]);
            NSLog(@"weight:%@", [kml.placemarks[i] weight]);
            NSLog(@"src:%@", [kml.placemarks[i] src]);
            NSLog(@"dest:%@", [kml.placemarks[i++] dest]);
            
            NSArray *coordRoute = [(KMLLineString *)kmlObject coordinates];
            for (id coord in coordRoute) {
                NSLog(@"{%f,%f}",[coord latitude],[coord longitude]);
            }
        }
    }
    
   */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)geometries:(NSArray*) arrayPlacemarks
{
    NSMutableArray *geometries = [NSMutableArray array];
    for (KMLPlacemark *placemark in arrayPlacemarks) {
        if (placemark.geometry) {
            if ([placemark.geometry isKindOfClass:[KMLMultiGeometry class]]) {
                KMLMultiGeometry *multiGeometry = (KMLMultiGeometry *)placemark.geometry;
                for (KMLAbstractGeometry *geometry in multiGeometry.geometries) {
                    if (geometry) {
                        [geometries addObject:geometry];
                    }
                }
                
            } else {
                [geometries addObject:placemark.geometry];
            }
        }
    }
    
    return geometries;
}

@end
