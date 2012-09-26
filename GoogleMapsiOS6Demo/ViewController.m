//
//  ViewController.m
//  GoogleMapsiOS6Demo
//
//  Created by Mladjan Antic on 9/13/12.
// updated by akipon 
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
    btn.frame = CGRectMake(10, 10, 60, 60);
    [btn setTitle:@"\U0001F4A9" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(test:)
  forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];

}

-(void)test:(UIButton*)button{
    flag=0;
    [man startUpdatingLocation];
    NSLog(@"test");
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
    if (flag) return;
    flag+=1;
    NSLog(@"mapreset");


    CLLocationCoordinate2D coordinate = newLocation.coordinate;
    MKMapPoint p = MKMapPointForCoordinate(coordinate);
//    NSLog(@"%f,%f",p.x,p.y);
//#define scale 32768.000000
#define scale (32768.0/8)

    MKMapRect visibleRect = [mapView mapRectThatFits:overlay.boundingMapRect];
    visibleRect.origin.x =p.x-(scale/2.0);
    visibleRect.origin.y = p.y-(scale/2.0);
    visibleRect.size.width =scale;
    visibleRect.size.height =scale;
    mapView.visibleMapRect = visibleRect;

//    CLLocationDegrees latitude = coordinate.latitude;
//    CLLocationDegrees longitude = coordinate.longitude;
//    NSString* urlString = [NSString stringWithFormat:@"&ll=%f,%f", latitude, longitude];
//    NSLog(@"%@",urlString);
    [man stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError");
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
