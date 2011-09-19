//
//  MapViewController.m
//  RMIT
//
//  Created by Jesse Collis on 18/09/11.
//  Copyright 2011 JC Multimedia Design. All rights reserved.
//

#import "MapViewController.h"

@implementation MapViewController

@synthesize mapView, navigationBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        // Custom initialization
    }
    return self;
}

-(void)dealloc
{    
    self.mapView = nil;
    self.navigationBar = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Properties

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
