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

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]))
    {
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.font = [UIFont boldSystemFontOfSize:14];
        
        self.detailTextLabel.backgroundColor = [UIColor clearColor];
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
        
        self.backgroundView = [[[PropertyCellBackgroundView alloc] initWithImageName:@"texture"] autorelease];
        self.selectedBackgroundView = [[[PropertyCellBackgroundView alloc] initWithImageName:@"texture-highlight"] autorelease];
    }
    
    return self;
}

@end
