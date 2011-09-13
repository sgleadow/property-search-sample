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
    
    self.properties = [NSArray arrayWithObjects:
                       [Property propertyWithAddess:@"1 Something St"
                                             suburb:@"Melbourne"
                                           postcode:@"3000"],
                       
                       [Property propertyWithAddess:@"2 Another Rd"
                                             suburb:@"Sydney"
                                           postcode:@"2000"],
                       
                       [Property propertyWithAddess:@"3 Some other St"
                                             suburb:@"Brisbane"
                                           postcode:@"4000"],
                       nil];
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
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"RMITCellIdentifier";
    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:cellIdentifier] autorelease];
    }
    
    // Configure cell...
                           
    return cell;
}

#pragma mark -
#pragma mark Search

- (IBAction)search
{
    
}

@end
