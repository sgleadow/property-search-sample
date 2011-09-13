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
#pragma mark UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self search];
}

- (void)viewDidUnload
{
    [tableView release];
    [searchBar release];
    
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
#pragma mark Search

- (IBAction)search
{
    [[LRResty client] get:@"http://rmit-property-search.heroku.com/search"
                 delegate:self];
}

#pragma mark -
#pragma mark LRRestyClientResponseDelegate

- (void)restClient:(LRRestyClient *)client
  receivedResponse:(LRRestyResponse *)response;
{
    NSData *data = [response responseData];
    
    // convert data to property objects
}

@end
