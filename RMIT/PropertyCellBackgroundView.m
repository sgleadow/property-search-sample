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

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    CGContextSetStrokeColorWithColor(context, [UIColor darkGrayColor].CGColor);
    CGContextMoveToPoint(context, 0, height-.5);
    CGContextAddLineToPoint(context, width, height-.5);
    CGContextStrokePath(context);
}

@end
