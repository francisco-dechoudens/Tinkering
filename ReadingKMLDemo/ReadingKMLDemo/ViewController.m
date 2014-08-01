//
//  ViewController.m
//  ReadingKMLDemo
//
//  Created by Frankie on 7/31/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "ViewController.h"
#import "KMLParser.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *map;
@end

@implementation ViewController{
    KMLParser *kmlParser;
    NSArray *overlays;
    NSArray *annotations;
    NSArray *placemarks;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self parseKML];
    [self addOverlay];
    [self addAnnotations];
    [self setVisibleAreaOfMap];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Locate the path to the route.kml file in the application's bundle
// and parse it with the KMLParser.
-(void)parseKML{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"kml"];
    NSURL *url = [NSURL fileURLWithPath:path];
    kmlParser = [[KMLParser alloc] initWithURL:url];
    [kmlParser parseKML];
    
   placemarks = [kmlParser placemarks];
    KMLPlacemark *placemark = placemarks[0];
   overlays = [kmlParser overlays];
   annotations = [kmlParser points];
}

// Add all of the MKOverlay objects parsed from the KML file to the map.
-(void)addOverlay{
    [self.map addOverlays:overlays];
}

// Add all of the MKAnnotation objects parsed from the KML file to the map.
-(void)addAnnotations{
    [self.map addAnnotations:annotations];
}

-(void)setVisibleAreaOfMap{
    // Walk the list of overlays and annotations and create a MKMapRect that
    // bounds all of them and store it into flyTo.
    MKMapRect flyTo = MKMapRectNull;
    for (id <MKOverlay> overlay in overlays) {
        if (MKMapRectIsNull(flyTo)) {
            flyTo = [overlay boundingMapRect];
        } else {
            flyTo = MKMapRectUnion(flyTo, [overlay boundingMapRect]);
        }
    }
    
    for (id <MKAnnotation> annotation in annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(flyTo)) {
            flyTo = pointRect;
        } else {
            flyTo = MKMapRectUnion(flyTo, pointRect);
        }
    }
    
    // Position the map so that all overlays and annotations are visible on screen.
    self.map.visibleMapRect = flyTo;
}

#pragma mark MKMapViewDelegate

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    return [kmlParser viewForOverlay:overlay];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    return [kmlParser viewForAnnotation:annotation];
}

@end
