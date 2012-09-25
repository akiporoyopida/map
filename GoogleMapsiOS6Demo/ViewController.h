//
//  ViewController.h
//  GoogleMapsiOS6Demo
//
//  Created by Mladjan Antic on 9/13/12.
//  Copyright (c) 2012 Imperio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "TileOverlay.h"
#import "TileOverlayView.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate> {
CLLocationManager *man;
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) TileOverlay *overlay;

@end
