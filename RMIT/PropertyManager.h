//
//  ListingManager.h
//  RMIT
//
//  Created by Jesse Collis on 18/09/11.
//  Copyright 2011 JC Multimedia Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LRResty/LRResty.h>

#import "Property.h"

@interface PropertyManager : NSObject <LRRestyClientResponseDelegate>

+ (PropertyManager *)sharedPropertyManager;

@property (nonatomic, retain) Property *selectedProperty;
@property (nonatomic, retain) NSArray *properties;

- (void)performPropertySearch:(NSDictionary *)params;

@end
