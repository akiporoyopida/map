//
//  ViewController.m
//  GoogleMapsiOS6Demo
//
//  Created by Mladjan Antic on 9/13/12.
//  Copyright (c) 2012 Imperio. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()

@end

@implementation ViewController

@synthesize overlay, mapView;
static int flag=0;
- (void)viewDidLoad
{
    [super viewDidLoad];

    man = [[CLLocationManager alloc] init];
    man.delegate = self;
    [man startUpdatingLocation];

    // OSM
    overlay = [[TileOverlay alloc] initOverlay];
    [mapView addOverlay:overlay];
    MKMapRect visibleRect = [mapView mapRectThatFits:overlay.boundingMapRect];
/*
    visibleRect.size.width /= 2;
    visibleRect.size.height /= 2;
    visibleRect.origin.x += visibleRect.size.width / 2;
    visibleRect.origin.y += visibleRect.size.height / 2;
 */
    visibleRect.size.width =32768.000000;
    visibleRect.size.height =32768.000000;
    mapView.visibleMapRect = visibleRect;
    // END OSM

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(10, 10, 30, 30);
    [btn setTitle:@"\U0001F4A9" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(test:)
  forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];

}

-(void)test:(UIButton*)button{
    flag=0;
    NSLog(@"test");
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
    if (flag) return;
    flag+=1;


    CLLocationCoordinate2D coordinate = newLocation.coordinate;
    MKMapPoint p = MKMapPointForCoordinate(coordinate);
//    NSLog(@"%f,%f",p.x,p.y);

    MKMapRect visibleRect = [mapView mapRectThatFits:overlay.boundingMapRect];
    visibleRect.origin.x =p.x-(32768.000000/2.0);
    visibleRect.origin.y = p.y-(32768.000000/2.0);
    visibleRect.size.width =32768.000000;
    visibleRect.size.height =32768.000000;
    mapView.visibleMapRect = visibleRect;

//    CLLocationDegrees latitude = coordinate.latitude;
//    CLLocationDegrees longitude = coordinate.longitude;
//    NSString* urlString = [NSString stringWithFormat:@"&ll=%f,%f", latitude, longitude];
//    NSLog(@"%@",urlString);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)ovl
{
    TileOverlayView *view = [[TileOverlayView alloc] initWithOverlay:ovl];
    view.tileAlpha = 1.0; // e.g. 0.6 alpha for semi-transparent overlay
    return view;
}


@end
