//
//  Property.m
//  RMIT
//
//  Created by Stewart Gleadow on 9/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Property.h"

@implementation Property

@synthesize address, suburb, postode, price, title, summary;

+ (Property *)propertyWithAddess:(NSString *)anAddress
                          suburb:(NSString *)aSuburb
                        postcode:(NSString *)aPostcode;
{
    Property *property = [[[Property alloc] init] autorelease];
    property.address = anAddress;
    property.suburb = aSuburb;
    property.postode = aPostcode;
    
    return property;
}

@end
