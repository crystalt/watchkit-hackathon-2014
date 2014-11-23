//
//  ViewController.m
//  WatchNav
//
//  Created by Crystal Tse on 11/23/14.
//  Copyright (c) 2014 WatchMe. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    
    mapView.showsUserLocation = YES;
    mapView.delegate = self;
}

- (void)getDirections
{
    // ZOOM TO THE RIGHT PLACE ON THE MAP
    MKUserLocation *userLocation = mapView.userLocation;
    NSLog(@"USER LOCATION %f %f", userLocation.location.coordinate.latitude,
          userLocation.location.coordinate.longitude);
    MKCoordinateRegion region =
    MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate,
                                       20000, 20000);
    [mapView setRegion:region animated:NO];
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    request.source = [MKMapItem mapItemForCurrentLocation];
    NSLog(@"sourceee? %@", request.source);
    
    // Coordinates of San Francisco
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(37.7833, -122.4167) addressDictionary:nil];
    request.destination = [[MKMapItem alloc] initWithPlacemark:placemark];
    request.requestsAlternateRoutes = NO;
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    
    [directions calculateDirectionsWithCompletionHandler:
     ^(MKDirectionsResponse *response, NSError *error) {
         if (error) {
             NSLog(@"ERORORORRO? %@", error);
             // Handle error
         } else {
             NSLog(@"no eror?");
             [self showRoute:response];
         }
     }];
}

-(void)showRoute:(MKDirectionsResponse *)response
{
    for (MKRoute *route in response.routes)
    {
        [mapView
         addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
        
        for (MKRouteStep *step in route.steps)
        {
            NSLog(@"%@ - %f", step.instructions, step.distance);
        }
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    MKPolylineRenderer *renderer =
    [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor blueColor];
    renderer.lineWidth = 5.0;
    return renderer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)zoomIn:(id)sender {
//    MKUserLocation *userLocation = mapView.userLocation;
//    
//    NSLog(@"LOCATION %@", userLocation);
//    
//    MKCoordinateRegion region =
//    MKCoordinateRegionMakeWithDistance (
//                                        userLocation.location.coordinate, 20000, 20000);
//    [mapView setRegion:region animated:NO];
    [self getDirections];
}

- (IBAction)changeMapType:(id)sender {
    if (mapView.mapType == MKMapTypeStandard) {
        mapView.mapType = MKMapTypeSatellite;
    }
    else {
        mapView.mapType = MKMapTypeStandard;
    }
}
//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
//{
//    mapView.centerCoordinate =
//    userLocation.location.coordinate;
//}

@end
