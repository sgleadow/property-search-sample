//
//  RootViewController.h
//  RMIT
//
//  Created by Stewart Gleadow on 9/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LRResty/LRResty.h>

@interface RootViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, LRRestyClientResponseDelegate>

@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *properties;

@end
