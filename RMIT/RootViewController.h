//
//  RootViewController.h
//  RMIT
//
//  Created by Stewart Gleadow on 9/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "PullToRefreshView.h"

@interface RootViewController : UIViewController <UITableViewDataSource,
                                                  UITableViewDelegate,
                                                  UISearchBarDelegate,
                                                  PullToRefreshViewDelegate,
                                                  MKMapViewDelegate>

@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;

@property (nonatomic, retain) NSArray *properties;
@property (nonatomic, retain) PullToRefreshView *pullRefreshView;
@property (nonatomic, assign) BOOL isInMapMode;

- (IBAction)search;
- (IBAction)toggleMapView:(id)sender;

@end
