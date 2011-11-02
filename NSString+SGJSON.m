#import "NSString+SGJSON.h"
#import "NSData+SGJSON.h"
#import <YAJLiOS/YAJL.h>

@implementation NSString (SGJSON)

- (id)sg_object_from_json;
{
  BOOL isAppleLibraryAvailable = NSClassFromString(@"NSJSONSerialization") != nil;
  return [self sg_object_from_json:isAppleLibraryAvailable];
}

- (id)sg_object_from_json:(BOOL)useAppleLibrary;
{
  NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
  return [data sg_object_from_json:useAppleLibrary];
}

@end

