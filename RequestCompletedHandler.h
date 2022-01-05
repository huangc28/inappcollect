// prodCollectRequestHandler encapsulates behavior after product info is collected.
#import "Foundation/Foundation.h"

@interface RequestCompletedHandler : NSObject
+ (void) prodCollectRequestHandler:(NSData *)data response:(NSURLResponse *)response error:(NSError *)error ;
@end
