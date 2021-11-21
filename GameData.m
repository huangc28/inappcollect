#import "Foundation/Foundation.h"
#import "GameData.h"

@implementation GameData 
+ (instancetype) sharedInstance {
    static GameData *instance = nil; 
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        instance = [[GameData alloc]init];
    });

    return instance;
}

@synthesize bundleID;

@end