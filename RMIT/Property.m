//
//  Property.m
//  RMIT
//
//  Created by Stewart Gleadow on 9/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Property.h"

@implementation Property

@synthesize address, suburb, postode, price, title, summary, photo;

+ (Property *)propertyWithAddess:(NSString *)anAddress
                          suburb:(NSString *)aSuburb
                        postcode:(NSString *)aPostcode
                           photo:(NSString *)photoName;
{
    Property *property = [[[Property alloc] init] autorelease];
    
    property.address = anAddress;
    property.suburb = aSuburb;
    property.postode = aPostcode;
    
    property.photo = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", photoName]];
    
    return property;
}

- (void)dealloc
{
    [address release];
    [suburb release];
    [postode release];
    [photo release];
    
    [super dealloc];
}

@end
