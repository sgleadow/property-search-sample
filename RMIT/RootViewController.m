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

@synthesize searchBar, tableView, properties, pullRefreshView;

- (void)dealloc
{
    [properties release];
    
    [super dealloc];
}

#pragma mark -
#pragma mark Load properties

-(IBAction)search
{
    [self.searchBar resignFirstResponder];
    
    NSString *url = @"http://rmit-property-search.heroku.com/search";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.searchBar.text)
    {
        [params setValue:self.searchBar.text forKey:@"q"];
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading properties";
    [[LRResty client] get:url
               parameters:params
                 delegate:self];
}

- (void)restClient:(LRRestyClient *)client receivedResponse:(LRRestyResponse *)response;
{
    NSDictionary *propertiesDict = [[response responseData] yajl_JSON];
    
    NSMutableArray *loadedProperties = [NSMutableArray array];
    for (NSDictionary *dict in [propertiesDict valueForKey:@"properties"])
    {
        Property *property = [Property propertyWithDictionary:dict];
        [loadedProperties addObject:property];
    }
    
    self.properties = loadedProperties;
    [self.pullRefreshView finishedLoading];
    [self.tableView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pullRefreshView = [[[PullToRefreshView alloc] initWithScrollView:self.tableView] autorelease];
    [self.pullRefreshView setDelegate:self];
    [self.tableView addSubview:self.pullRefreshView];
    
    [self search];
}

- (void)viewDidUnload
{
    [tableView release];
    [searchBar release];
    [pullRefreshView release];
    
    [super viewDidUnload];
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
        cell = [[[PropertyCell alloc] initWithReuseIdentifier:cellIdentifier] autorelease];
    }

    Property *property = [self.properties objectAtIndex:indexPath.row];
    cell.textLabel.text = property.address;
    cell.detailTextLabel.text = property.location;
    cell.imageView.image = property.photo;
                           
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Property *property = [self.properties objectAtIndex:indexPath.row];
    DetailViewController *controller = [[[DetailViewController alloc] initWithProperty:property] autorelease];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    [self.searchBar resignFirstResponder];
}

#pragma mark -
#pragma mark UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
{
    [self search];
}

#pragma mark -
#pragma mark PullToRefreshViewDelegate

- (void)pullToRefreshViewShouldRefresh:(PullToRefreshView *)view;
{
    [self search];
}

@end
