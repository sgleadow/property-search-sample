//
//  DetailViewController.h
//  RMIT
//
//  Created by Stewart Gleadow on 10/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Property.h"

@interface DetailViewController : UIViewController

- (id)initWithProperty:(Property *)property;

@property (nonatomic, retain) Property *property;

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UILabel *address;
@property (nonatomic, retain) IBOutlet UILabel *location;
@property (nonatomic, retain) IBOutlet UIImageView *photo;
@property (nonatomic, retain) IBOutlet UILabel *summary;
@property (nonatomic, retain) IBOutlet UILabel *description;

@end
