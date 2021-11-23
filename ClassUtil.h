#import "Foundation/Foundation.h"

// HttpUtil is a singleton class used to request remote server.
@interface ClassUtil:NSObject {}
+ (instancetype)sharedInstance;
+ (void)dumpCallStack;
- (void)dumpClassInfo:(Class)clazz;

@end
