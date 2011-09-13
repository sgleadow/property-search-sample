//
//  Property.m
//  RMIT
//
//  Created by Stewart Gleadow on 9/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Property.h"

@implementation Property

@synthesize address, suburb, postode, summary, photo;

+ (Property *)propertyWithDictionary:(NSDictionary *)dict
{
    return [Property propertyWithAddess:[dict valueForKey:@"address"]
                                 suburb:[dict valueForKey:@"suburb"]
                               postcode:[dict valueForKey:@"postcode"]
                                  photo:[dict valueForKey:@"photo"]
                                summary:[dict valueForKey:@"summary"]];
}

+ (Property *)propertyWithAddess:(NSString *)anAddress
                          suburb:(NSString *)aSuburb
                        postcode:(NSString *)aPostcode
                           photo:(NSString *)photoName
                         summary:(NSString *)aSummary;
{
    Property *property = [[[Property alloc] init] autorelease];
    
    property.address = anAddress;
    property.suburb = aSuburb;
    property.postode = aPostcode;
    
    property.photo = [UIImage imageNamed:photoName];
    property.summary = aSummary;
    
    return property;
}


+ (Property *)propertyWithAddess:(NSString *)anAddress
                          suburb:(NSString *)aSuburb
                        postcode:(NSString *)aPostcode;
{
    return [Property propertyWithAddess:anAddress
                                 suburb:aSuburb
                               postcode:aPostcode
                                  photo:nil
                                summary:nil];
}

- (void)dealloc
{
    [address release];
    [suburb release];
    [postode release];
    [photo release];
    [summary release];
    
    [super dealloc];
}

- (NSString *)location;
{
    return [NSString stringWithFormat:@"%@, %@", self.suburb.uppercaseString, self.postode];
}

@end
