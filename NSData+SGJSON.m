#import "NSData+SGJSON.h"
#import <YAJLiOS/YAJL.h>

@implementation NSData (SGJSON)

- (id)sg_object_from_json;
{
  BOOL isAppleLibraryAvailable = NSClassFromString(@"NSJSONSerialization") != nil;
  return [self sg_object_from_json:isAppleLibraryAvailable];
}

- (id)sg_object_from_json:(BOOL)useAppleLibrary;
{
  id jsonValue = nil;
  if (useAppleLibrary)
  {
    NSError *err = nil;
    Class jsonClass = NSClassFromString(@"NSJSONSerialization");
    jsonValue = [jsonClass JSONObjectWithData:self
                                      options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
                                        error:&err];
  }
  else
  {
    jsonValue = [self yajl_JSON];
  }
  
  return jsonValue;
}

@end

