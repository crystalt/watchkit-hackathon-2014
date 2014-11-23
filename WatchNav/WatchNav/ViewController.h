//
//  ViewController.h
//  WatchNav
//
//  Created by Crystal Tse on 11/23/14.
//  Copyright (c) 2014 WatchMe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface ViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (strong, nonatomic) MKMapItem *destination;

- (IBAction)zoomIn:(id)sender;
- (IBAction)changeMapType:(id)sender;

@end

