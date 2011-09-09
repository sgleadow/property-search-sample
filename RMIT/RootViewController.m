//
//  RootViewController.m
//  RMIT
//
//  Created by Stewart Gleadow on 9/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "Property.h"
#import "PropertyCell.h"

@implementation RootViewController

@synthesize searchBar, tableView, properties;

- (void)awakeFromNib
{
    self.properties = [NSArray arrayWithObjects:
                       [Property propertyWithAddess:@"1 Collins St"
                                             suburb:@"Melbourne"
                                           postcode:@"3000"],
                       
                       [Property propertyWithAddess:@"20 Flinders St"
                                             suburb:@"Melbourne"
                                           postcode:@"3000"],
                       
                       [Property propertyWithAddess:@"220 Glenferrie Rd"
                                             suburb:@"Hawthorn"
                                           postcode:@"3122"],
                       
                       [Property propertyWithAddess:@"500 Lygon St"
                                             suburb:@"Carlton"
                                           postcode:@"3053"],
                       
                       [Property propertyWithAddess:@"200 Johnston St"
                                             suburb:@"Collingwood"
                                           postcode:@"3066"],
                       
                       [Property propertyWithAddess:@"123 High St"
                                             suburb:@"Kew"
                                           postcode:@"3101"],
                       
                       [Property propertyWithAddess:@"600 Victoria St"
                                             suburb:@"Richmond"
                                           postcode:@"3121"],
                       
                       [Property propertyWithAddess:@"680 Burke Rd"
                                             suburb:@"Camberwell"
                                           postcode:@"3124"],
                       
                       [Property propertyWithAddess:@"300 Mont Albert Rd"
                                             suburb:@"Surrey Hills"
                                           postcode:@"3127"],
                       
                         nil
                         ];
}

- (void)dealloc
{
    self.properties = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
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
    cell.detailTextLabel.text = property.suburb;
                           
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    [self.searchBar resignFirstResponder];
}

#pragma mark -
#pragma mark UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
{
    [self.searchBar resignFirstResponder];
}


@end
