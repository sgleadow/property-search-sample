//
//  MapViewController.m
//  RMIT
//
//  Created by Jesse Collis on 18/09/11.
//  Copyright 2011 JC Multimedia Design. All rights reserved.
//

#import "MapViewController.h"
#import "PropertyManager.h"

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
    }
    return self;
}

-(void)dealloc
{
    [[PropertyManager sharedPropertyManager] removeObserver:self forKeyPath:@"properties"];

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

@end
