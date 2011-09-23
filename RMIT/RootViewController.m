//
//  RootViewController.m
//  RMIT
//
//  Created by Stewart Gleadow on 9/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Property.h"
#import "PropertyCell.h"
#import "MBProgressHUD.h"
#import "DetailViewController.h"

#import "RootViewController.h"

#import "MKMapView+Zoom.h"
#import "PropertyManager.h"

@implementation RootViewController

@synthesize searchBar, tableView, properties, pullRefreshView, mapView, isInMapMode, selectedCellIndex;

- (void)dealloc
{
    [[PropertyManager sharedPropertyManager] removeObserver:self forKeyPath:@"properties"];
    [[PropertyManager sharedPropertyManager] removeObserver:self forKeyPath:@"selectedProperty"];

    RELEASE_SAFELY(properties);
    RELEASE_SAFELY(pullRefreshView);
    RELEASE_SAFELY(tableView);
    RELEASE_SAFELY(searchBar);
    RELEASE_SAFELY(mapView);

    [super dealloc];
}
    

#pragma mark -
#pragma mark UIViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
  if ((self = [super initWithCoder:aDecoder]))
  {
    self.isInMapMode = NO;
    
    //Add observers to the property manager 
    [[PropertyManager sharedPropertyManager] addObserver:self 
                                              forKeyPath:@"properties" 
                                                 options:(NSKeyValueObservingOptionNew) 
                                                 context:nil];

     [[PropertyManager sharedPropertyManager] addObserver:self
                                               forKeyPath:@"selectedProperty"
                                                  options:(NSKeyValueObservingOptionNew)
                                                  context:nil];                                                 
  }
  return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pullRefreshView = [[[PullToRefreshView alloc]
                                initWithScrollView:self.tableView]
                               autorelease];

    self.pullRefreshView.delegate = self;
    [self.tableView addSubview:self.pullRefreshView];
    
    // Use the following three lines to change the 'Back' button
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: @"Back"
                                                                      style: UIBarButtonItemStyleBordered
                                                                     target: nil action: nil];
    self.navigationItem.backBarButtonItem = newBackButton;
    [newBackButton release];

    self.mapView.delegate = self;
    [self search];
}

- (void)viewDidUnload
{
    self.selectedCellIndex = NSUIntegerMax;
    self.pullRefreshView = nil;
    self.tableView = nil;
    self.searchBar = nil;
    self.mapView = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - 
#pragma mark KVO

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"properties"])
    {
        [self.mapView removeAnnotations:self.mapView.annotations];
        
        self.properties = [change objectForKey:NSKeyValueChangeNewKey];

        [self.mapView addAnnotations:self.properties];
        [self.mapView zoomToFitAnnotations];

        [self.tableView reloadData];
        [self.pullRefreshView finishedLoading];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    else if([keyPath isEqualToString:@"selectedProperty"])
    {
        Property *newSelectedProperty = [change objectForKey:NSKeyValueChangeNewKey];

        NSUInteger newSelectedIndex = [[[PropertyManager sharedPropertyManager] properties] indexOfObject:newSelectedProperty];

        if (newSelectedIndex != self.selectedCellIndex)
        {
            self.selectedCellIndex = newSelectedIndex;
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:newSelectedIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        }
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.properties.count;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"RMITCellIdentifier";
    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[[PropertyCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:cellIdentifier] autorelease];
    }
    
    Property *property = [self.properties objectAtIndex:indexPath.row];
    cell.textLabel.text = property.address;
    cell.detailTextLabel.text = property.location;
    cell.imageView.image = property.photo;

    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    Property *property = [self.properties objectAtIndex:indexPath.row];
    self.selectedCellIndex = indexPath.row;

    [PropertyManager sharedPropertyManager].selectedProperty = property;
    
    DetailViewController *controller = [[[DetailViewController alloc]
                                         initWithProperty:property]
                                        autorelease];

    [self.navigationController pushViewController:controller 
                                         animated:YES];
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
}

#pragma mark -
#pragma UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
{
    [self search];
}

#pragma mark -
#pragma mark Search

- (IBAction)search
{
    [self.searchBar resignFirstResponder];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.searchBar.text)
    {
        [params setValue:self.searchBar.text forKey:@"q"];
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading properties...";
    
    [self.mapView removeAnnotations:[self.mapView annotations]];

    [[PropertyManager sharedPropertyManager] performPropertySearch:params];
}

#pragma mark - 
#pragma mark Toggle Map View

// This method is called from the button in the top right of the navigation bar. 
// It toggles between the map view and the table view and keeps it's current state in a BOOL property on this controller.
// The magic here is using UIView transitionFromView:toView:duration:options:completion: 
// Note that the block used in the final paremeter is only supported in iOS 4+, and the block is called AFTER the animation is complete.

- (IBAction)toggleMapView:(id)sender
{
    UIView *fromView = self.tableView;
    UIView *toView = self.mapView;

    if (self.isInMapMode)
    {
        fromView = self.mapView;
        toView = self.tableView;
    }

    UIViewAnimationOptions animationOptions = self.isInMapMode ? UIViewAnimationOptionTransitionFlipFromRight : UIViewAnimationOptionTransitionFlipFromLeft;

    [sender setEnabled:NO];

    [UIView transitionFromView:fromView toView:toView duration:0.4 options:animationOptions completion:^(BOOL finished) {
        self.isInMapMode = !self.isInMapMode;
        [sender setTitle:self.isInMapMode ? @"List":@"Map"];
        [sender setEnabled:YES];
    }];
}


#pragma mark -
#pragma mark PullToRefreshViewDelegate

- (void)pullToRefreshViewShouldRefresh:(PullToRefreshView *)view;
{
    [self search];
}

#pragma mark - 
#pragma mark MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)senderMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    NSString *AnnotationViewReuseIdentifier = @"propertyPinReuseIdentifier";
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[[senderMapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewReuseIdentifier] retain];

    if (annotationView == nil)
    {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewReuseIdentifier];
        annotationView.canShowCallout = YES;
        annotationView.pinColor = MKPinAnnotationColorGreen;
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }
    else
    {
        annotationView.annotation = annotation;
    }
    
    return [annotationView autorelease];
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    DetailViewController *controller = [[[DetailViewController alloc]
                                         initWithProperty:(Property *)view.annotation]
                                        autorelease];
    
    [self.navigationController pushViewController:controller 
                                         animated:YES];
}



@end
