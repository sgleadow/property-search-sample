//
//  SplitViewDelegate.m
//  RMIT
//
//  Created by Jesse Collis on 18/09/11.
//  Copyright 2011 JC Multimedia Design. All rights reserved.
//

#import "SplitViewDelegate.h"

@implementation SplitViewDelegate

- (id)init
{
    if ((self = [super init]))
    {
        // Initialization code here.
    }
    return self;
}



- (void)splitViewController:(UISplitViewController*)svc 
          popoverController:(UIPopoverController*)pc 
  willPresentViewController:(UIViewController *)aViewController
{
    NSLog(@"WillPresentViewController");
}


- (void)splitViewController:(UISplitViewController*)svc 
     willHideViewController:(UIViewController *)aViewController 
          withBarButtonItem:(UIBarButtonItem*)barButtonItem 
       forPopoverController:(UIPopoverController*)pc
{
    NSLog(@"WillHideViewController");
}

- (void)splitViewController:(UISplitViewController*)svc 
     willShowViewController:(UIViewController *)aViewController 
  invalidatingBarButtonItem:(UIBarButtonItem *)button
{
    NSLog(@"WillShowViewController");
}



@end
