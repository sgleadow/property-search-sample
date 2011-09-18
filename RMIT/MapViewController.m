//
//  MapViewController.m
//  RMIT
//
//  Created by Jesse Collis on 18/09/11.
//  Copyright 2011 JC Multimedia Design. All rights reserved.
//

#import "MapViewController.h"
#import "PropertyManager.h"
#import "MKMapView+Zoom.h"

@implementation MapViewController

@synthesize mapView, navigationBar, properties;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        [[PropertyManager sharedPropertyManager] addObserver:self 
                                                  forKeyPath:@"properties" 
                                                     options:NSKeyValueObservingOptionNew 
                                                     context:nil];

        [[PropertyManager sharedPropertyManager] addObserver:self
                                                  forKeyPath:@"selectedProperty"
                                                     options:(NSKeyValueObservingOptionNew)
                                                     context:nil];
    }
    return self;
}

-(void)dealloc
{
    [[PropertyManager sharedPropertyManager] removeObserver:self forKeyPath:@"properties"];
    [[PropertyManager sharedPropertyManager] removeObserver:self forKeyPath:@"selectedProperty"];

    self.properties = nil;
    self.mapView = nil;
    self.navigationBar = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - MapViewController

- (void)setDetailPopOverButton:(UIBarButtonItem *)button;
{
    [self.navigationBar.topItem setLeftBarButtonItem: button animated:NO];
}

#pragma mark - KVO

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"properties"])
    {
        [self.mapView removeAnnotations:self.mapView.annotations];
        self.properties = [change objectForKey:NSKeyValueChangeNewKey];
        [self.mapView addAnnotations:self.properties];
        [self.mapView zoomToFitAnnotations];
    }
    else if ([keyPath isEqualToString:@"selectedProperty"])
    {
        NSArray *selectedAnnotations = self.mapView.selectedAnnotations;
        for (id<MKAnnotation>annotation in selectedAnnotations)
        {
            [self.mapView deselectAnnotation:annotation animated:YES];
        }
        
        Property *newSelectedProperty = [change objectForKey:NSKeyValueChangeNewKey];
        [self.mapView selectAnnotation:newSelectedProperty animated:YES];
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.mapView = nil;
    self.navigationBar = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - MKMapViewDelegate

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    PropertyManager *manager = [PropertyManager sharedPropertyManager];
    
    if ((Property *)view.annotation != manager.selectedProperty)
    {
        [PropertyManager sharedPropertyManager].selectedProperty = (Property *)view.annotation;
    }
}


@end
