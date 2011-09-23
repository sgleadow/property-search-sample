//
//  MapViewController.h
//  RMIT
//
//  Created by Jesse Collis on 18/09/11.
//  Copyright 2011 JC Multimedia Design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, retain) NSArray *properties;

- (void)setDetailPopOverButton:(UIBarButtonItem *)button;

@end
