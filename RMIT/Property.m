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

+ (Property *)propertyWithDictionary:(NSDictionary *)dict
{
    return [Property propertyWithAddess:[dict valueForKey:@"address"]
                                 suburb:[dict valueForKey:@"suburb"]
                               postcode:[dict valueForKey:@"postcode"]
                                  photo:[dict valueForKey:@"photo"]];
}

+ (Property *)propertyWithAddess:(NSString *)anAddress
                          suburb:(NSString *)aSuburb
                        postcode:(NSString *)aPostcode
                           photo:(NSString *)photoName;
{
    Property *property = [[[Property alloc] init] autorelease];
    
    property.address = anAddress;
    property.suburb = aSuburb;
    property.postode = aPostcode;
    
    property.photo = [UIImage imageNamed:photoName];
    
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

- (NSString *)location;
{
    return [NSString stringWithFormat:@"%@, %@", self.suburb.uppercaseString, self.postode];
}

@end
