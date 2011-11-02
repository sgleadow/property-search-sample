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
  //id obj = [jsonData_ sg
}

- (void)test_parse_JSON_string_using_Apple_library
{

}

- (void)test_parse_JSON_data_using_YAJL_library
{

}

- (void)test_parse_JSON_string_using_YAJL_library
{

}

@end
