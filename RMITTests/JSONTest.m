#import <SenTestingKit/SenTestingKit.h>
#import "SGJSON.h"

@interface JSONTest : SenTestCase
{
  NSString *jsonString_;
  NSData *jsonData_;
}
@end

@implementation JSONTest

- (void)setUp
{
  NSBundle *bundle = [NSBundle bundleForClass:[self class]];
  NSString *file = [bundle pathForResource:@"test_fixture" ofType:@"json"];
  
  jsonString_ = [[NSString stringWithContentsOfFile:file
                                           encoding:NSUTF8StringEncoding
                                              error:nil] retain];
  
  jsonData_ = [[NSData dataWithContentsOfFile:file] retain];
}

- (void)tearDown
{
  [jsonString_ release], jsonString_ = nil;
  [jsonData_ release], jsonData_ = nil;
}

#pragma mark -
#pragma mark Tests

- (void)test_parse_JSON_data_using_Apple_library
{
  id obj = [jsonData_ sg_object_from_json:YES];

  STAssertNotNil(obj, nil);
  
  NSString *title = [obj valueForKey:@"title"];
  STAssertEqualObjects(title, @"our title", nil);
  
  NSArray *properties = [obj valueForKey:@"properties"];
  STAssertEquals([properties count], 2u, nil);
  
  NSString *summary = [[properties objectAtIndex:1] valueForKey:@"summary"];
  STAssertEqualObjects(summary, @"Rupertswood, Birthplace of The Ashes", nil);
}

- (void)test_parse_JSON_string_using_Apple_library
{
  id obj = [jsonString_ sg_object_from_json:YES];

  STAssertNotNil(obj, nil);
  
  NSString *title = [obj valueForKey:@"title"];
  STAssertEqualObjects(title, @"our title", nil);
  
  NSArray *properties = [obj valueForKey:@"properties"];
  STAssertEquals([properties count], 2u, nil);
  
  NSString *summary = [[properties objectAtIndex:1] valueForKey:@"summary"];
  STAssertEqualObjects(summary, @"Rupertswood, Birthplace of The Ashes", nil);
}

- (void)test_parse_JSON_data_using_YAJL_library
{
  id obj = [jsonData_ sg_object_from_json:NO];

  STAssertNotNil(obj, nil);
  
  NSString *title = [obj valueForKey:@"title"];
  STAssertEqualObjects(title, @"our title", nil);
  
  NSArray *properties = [obj valueForKey:@"properties"];
  STAssertEquals([properties count], 2u, nil);
  
  NSString *summary = [[properties objectAtIndex:1] valueForKey:@"summary"];
  STAssertEqualObjects(summary, @"Rupertswood, Birthplace of The Ashes", nil);
}

- (void)test_parse_JSON_string_using_YAJL_library
{
  id obj = [jsonString_ sg_object_from_json:NO];

  STAssertNotNil(obj, nil);
  
  NSString *title = [obj valueForKey:@"title"];
  STAssertEqualObjects(title, @"our title", nil);
  
  NSArray *properties = [obj valueForKey:@"properties"];
  STAssertEquals([properties count], 2u, nil);
  
  NSString *summary = [[properties objectAtIndex:1] valueForKey:@"summary"];
  STAssertEqualObjects(summary, @"Rupertswood, Birthplace of The Ashes", nil);
}

- (void)test_either_library_works
{
  id obj1 = [jsonString_ sg_object_from_json];
  STAssertNotNil(obj1, nil);
  
  id obj2 = [jsonData_ sg_object_from_json];
  STAssertNotNil(obj2, nil);
}

@end
