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
        
        UIView *topShadow = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shadow-top"]] autorelease];
        topShadow.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.selectedBackgroundView addSubview:topShadow];
        
        UIImage *bottom = [UIImage imageNamed:@"shadow-bottom"];
        UIView *bottomShadow = [[[UIImageView alloc] initWithImage:bottom] autorelease];
        bottomShadow.frame = CGRectMake(0, -bottom.size.height, bottom.size.width, bottom.size.height);
        bottomShadow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [self.selectedBackgroundView addSubview:bottomShadow];
    }
    
    return self;
}

@end
