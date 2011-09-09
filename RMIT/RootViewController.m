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
                       
                       [Property propertyWithAddess:@"Government House Dr"
                                             suburb:@"Melbourne"
                                           postcode:@"3004"
                                              photo:@"photo9"],
                       
                       [Property propertyWithAddess:@"60-74 Buckingham Drive"
                                             suburb:@"Heidelberg"
                                           postcode:@"3084"
                                              photo:@"photo1"],
                       
                       [Property propertyWithAddess:@"cnr Williams Road & Lechlade Ave"
                                             suburb:@"South Yarra"
                                           postcode:@"3141" 
                                              photo:@"photo2"],
                       
                       [Property propertyWithAddess:@"120 Clarendon Street"
                                             suburb:@"East melbourne"
                                           postcode:@"3002"
                                              photo:@"photo3"],
                       
                       [Property propertyWithAddess:@"K Rd"
                                             suburb:@"Werribee"
                                           postcode:@"3030"
                                              photo:@"photo4"],
                       
                       [Property propertyWithAddess:@"336 Glenferrie Road"
                                             suburb:@"Malvern"
                                           postcode:@"3144"
                                              photo:@"photo5"],
                       
                       [Property propertyWithAddess:@"192 Hotham Street"
                                             suburb:@"Elsternwick"
                                           postcode:@"3185"
                                              photo:@"photo6"],
                       
                       [Property propertyWithAddess:@"120-126 Toorak Rd West"
                                             suburb:@"South Yarra"
                                           postcode:@"3141"
                                              photo:@"photo7"],
                       
                       [Property propertyWithAddess:@"54 Mont Albert Rd"
                                             suburb:@"Canterbury"
                                           postcode:@"3126"
                                              photo:@"photo8"],
                       
                         nil
                         ];
}

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
    cell.imageView.image = property.photo;
                           
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
