#import "Foundation/Foundation.h"

// HttpUtil is a singleton class used to request remote server.
@interface GameData:NSObject {
    NSString *_bundleID;
}
+ (instancetype)sharedInstance; 

@property(retain, nonatomic) NSString *bundleID; // @synthesize bundleID=_bundleID

@end