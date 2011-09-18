//
//  SplitViewDelegate.m
//  RMIT
//
//  Created by Jesse Collis on 18/09/11.
//  Copyright 2011 JC Multimedia Design. All rights reserved.
//

#import "SplitViewDelegate.h"
#import "MapViewController.h"

@implementation SplitViewDelegate

- (id)init
{
    if ((self = [super init]))
    {
        // Initialization code here.
    }
    return self;
}

//Tells the delegate that the hidden view controller is about to be displayed in a popover.

- (void)splitViewController:(UISplitViewController*)svc 
          popoverController:(UIPopoverController*)pc 
  willPresentViewController:(UIViewController *)aViewController
{

}

//Tells the delegate that the specified view controller is about to be hidden.

- (void)splitViewController:(UISplitViewController*)svc 
     willHideViewController:(UIViewController *)aViewController 
          withBarButtonItem:(UIBarButtonItem*)barButtonItem 
       forPopoverController:(UIPopoverController*)pc
{
    MapViewController *mapViewController = (MapViewController *)[svc.viewControllers objectAtIndex:1];
    barButtonItem.title = @"Search Results";
    [mapViewController setDetailPopOverButton:barButtonItem];
}

//Tells the delegate that the specified view controller is about to be shown again.

- (void)splitViewController:(UISplitViewController*)svc 
     willShowViewController:(UIViewController *)aViewController 
  invalidatingBarButtonItem:(UIBarButtonItem *)button
{
    MapViewController *mapViewController = (MapViewController *)[svc.viewControllers objectAtIndex:1];
    [mapViewController setDetailPopOverButton:nil];
}



@end
