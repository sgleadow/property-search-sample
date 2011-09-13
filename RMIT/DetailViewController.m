//
//  DetailViewController.m
//  RMIT
//
//  Created by Stewart Gleadow on 10/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation DetailViewController

@synthesize scrollView, address, location, summary, photo, property, description;

- (id)initWithProperty:(Property *)aProperty
{
    if ((self = [super initWithNibName:@"DetailViewController" bundle:nil]))
    {
        self.property = aProperty;
        self.title = @"Property";
    }
    
    return self;
}

- (void)dealloc
{
    [scrollView release];
    [address release];
    [location release];
    [summary release];
    [photo release];
    [property release];
    [description release];

    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad;
{
    [super viewDidLoad];
    UIImage *bg = [UIImage imageNamed:@"texture"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bg];
    
    self.address.text = self.property.address;
    self.location.text = self.property.location;
    self.photo.image = self.property.photo;
    self.summary.text = self.property.summary;
    
    CALayer *layer = self.photo.layer;
    layer.shadowOpacity = 1;
    layer.shadowOffset = CGSizeMake(0, 2);
}

- (void)viewDidUnload
{
    [scrollView release];
    [address release];
    [location release];
    [summary release];
    [photo release];
    [property release];
    [description release];

    [super viewDidUnload];
}

@end
