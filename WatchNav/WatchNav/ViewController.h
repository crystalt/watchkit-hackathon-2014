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
@property (strong, nonatomic) NSURLConnection *connection;
@property (strong, nonatomic) IBOutlet UITextField *addressBar;

- (IBAction)directionButton:(id)sender;

@end

