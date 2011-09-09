//
//  PropertyCell.m
//  RMIT
//
//  Created by Stewart Gleadow on 9/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PropertyCell.h"

@implementation PropertyCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]))
    {
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.detailTextLabel.backgroundColor = [UIColor clearColor];
        
        self.backgroundView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
        self.backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"texture"]];
        
        self.selectedBackgroundView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
        self.selectedBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"texture-highlight"]];
    }
    
    return self;
}

@end
