//
//  Property.h
//  RMIT
//
//  Created by Stewart Gleadow on 9/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Property : NSObject

+ (Property *)propertyWithDictionary:(NSDictionary *)dict;

+ (Property *)propertyWithAddess:(NSString *)anAddress
                          suburb:(NSString *)aSuburb
                        postcode:(NSString *)aPostcode
                           photo:(NSString *)photoName;

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *suburb;
@property (nonatomic, copy) NSString *postode;

@property (nonatomic, retain) UIImage *photo;

@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *summary;

- (NSString *)location;

@end
