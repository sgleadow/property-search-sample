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
    CGRect bounds = self.bounds;
    CGFloat width = bounds.size.width;
    CGFloat height = bounds.size.height;
    
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetShadow(context, CGSizeMake(0, 1), 0);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 1), 0, [UIColor whiteColor].CGColor);
    
    CGContextMoveToPoint(context, 0, height-1.5);
    CGContextAddLineToPoint(context, width, height-1.5);
    CGContextStrokePath(context);
}

@end
