//
//  PropertyCellBackgroundView.m
//  RMIT
//
//  Created by Stewart Gleadow on 10/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PropertyCellBackgroundView.h"

@implementation PropertyCellBackgroundView

- (id)initWithImageName:(NSString *)imageName
{
    if ((self = [super initWithFrame:CGRectZero]))
    {
        UIImage *img = [UIImage imageNamed:imageName];
        self.backgroundColor = [UIColor colorWithPatternImage:img];
    }
    return self;
}

@end
