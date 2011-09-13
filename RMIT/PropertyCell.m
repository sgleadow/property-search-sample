//
//  PropertyCell.m
//  RMIT
//
//  Created by Stewart Gleadow on 9/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "PropertyCell.h"
#import "PropertyCellBackgroundView.h"

@implementation PropertyCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:style
                     reuseIdentifier:reuseIdentifier]))
    {
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.highlightedTextColor = [UIColor darkGrayColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.font = [UIFont boldSystemFontOfSize:14];
        self.textLabel.shadowColor = [UIColor whiteColor];
        self.textLabel.shadowOffset = CGSizeMake(0, 1);
        
        self.detailTextLabel.textColor = [UIColor lightGrayColor];
        self.detailTextLabel.highlightedTextColor = [UIColor lightGrayColor];
        self.detailTextLabel.backgroundColor = [UIColor clearColor];
        self.detailTextLabel.font = [UIFont boldSystemFontOfSize:12];
        self.detailTextLabel.shadowColor = [UIColor whiteColor];
        self.detailTextLabel.shadowOffset = CGSizeMake(0, 1);
        
        self.backgroundView = [[[PropertyCellBackgroundView alloc]
                               initWithImageName:@"texture"] autorelease];
        self.selectedBackgroundView = [[[PropertyCellBackgroundView alloc]
                                initWithImageName:@"texture-highlight"] autorelease];
    }
    
    return self;
}

@end
