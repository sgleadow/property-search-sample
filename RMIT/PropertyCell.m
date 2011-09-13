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
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        // More cell styling code goes here
    }
    
    return self;
}

@end
