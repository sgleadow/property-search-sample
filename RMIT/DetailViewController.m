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
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Show"
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self
                                                                                 action:@selector(show)];
    }
    
    return self;
}

-(void)dealloc
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


- (void)show
{
    self.summary.text = self.property.summary;
}

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad;
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"texture"]];
    
    self.address.text = self.property.address;
    self.location.text = self.property.location;
    self.photo.image = self.property.photo;
    
    CALayer *layer = self.photo.layer;
    layer.shadowOpacity = 1;
    layer.shadowOffset = CGSizeMake(0, 2);
    
    //Set the scrollView contemt size based on the maximum Y value of the description UILabel. 
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, CGRectGetMaxY(self.description.frame));

  [super viewDidLoad];
}

-(void)viewDidUnload
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
