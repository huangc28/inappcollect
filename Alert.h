#import "Foundation/Foundation.h"

typedef void (^alertUIViewConfirmHandler)();

@interface Alert:NSObject {
}

+ (void)show:(alertUIViewConfirmHandler)handler title:(NSString *)title message:(NSString *)message;
@end

