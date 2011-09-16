//
//  RootViewController.m
//  RMIT
//
//  Created by Stewart Gleadow on 9/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <YAJLiOS/YAJL.h>

#import "Property.h"
#import "PropertyCell.h"
#import "MBProgressHUD.h"
#import "DetailViewController.h"

#import "RootViewController.h"

@implementation RootViewController

@synthesize searchBar, tableView, properties, pullRefreshView, mapView, isInMapMode;

- (void)dealloc
{
    self.properties = nil;
    self.pullRefreshView = nil;
    self.tableView = nil;
    self.searchBar = nil;
    self.mapView = nil;
    [super dealloc];
}
    

#pragma mark -
#pragma mark UIViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
  if ((self = [super initWithCoder:aDecoder]))
  {
    self.isInMapMode = NO;
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

    [self search];
}

- (void)viewDidUnload
{
    self.pullRefreshView = nil;
    self.tableView = nil;
    self.searchBar = nil;
    self.mapView = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIDeviceOrientationIsPortrait(interfaceOrientation);
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

    [[LRResty client] get:@"http://rmit-property-search.heroku.com/search"
               parameters:params
                 delegate:self];
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
#pragma mark LRRestyClientResponseDelegate

- (void)restClient:(LRRestyClient *)client
  receivedResponse:(LRRestyResponse *)response;
{
    NSData *data = [response responseData];
    
    NSDictionary *jsonDictionary = [data yajl_JSON];
    NSArray *propertiesArray = [jsonDictionary valueForKey:@"properties"];

    NSMutableArray *newProperties = [NSMutableArray array];
    for (NSDictionary *dict in propertiesArray)
    {
        Property *property = [Property propertyWithDictionary:dict];
        [newProperties addObject:property];
    }

    self.properties = newProperties;
    
    [self.mapView addAnnotations:self.properties];
    
    [self.tableView reloadData];
    [self.pullRefreshView finishedLoading];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark -
#pragma mark PullToRefreshViewDelegate

- (void)pullToRefreshViewShouldRefresh:(PullToRefreshView *)view;
{
    [self search];
}

@end
