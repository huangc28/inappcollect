#import "Foundation/Foundation.h"
#import "SpringBoard/SpringBoard.h"
#import "Alert.h"

// Reference articles:
//  - https://stackoverflow.com/questions/67110169/objective-c-uialertcontroller-crash-on-ios-14
//  - [How to uialertcontroller in IOS app](https://stackoverflow.com/questions/36155769/how-to-show-uialertcontroller-from-appdelegate)
@implementation Alert
+ (void) show:(alertUIViewConfirmHandler)handler
	title:(NSString* )title
	message:(NSString*)message
{
	dispatch_async(dispatch_get_main_queue(), ^{
		__block UIWindow *topWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
		topWindow.rootViewController = [UIViewController new];
		topWindow.windowLevel = UIWindowLevelAlert + 1;

		UIAlertController* alert = [
			UIAlertController
				alertControllerWithTitle:title
				message:message
				preferredStyle:UIAlertControllerStyleAlert
		];

		[
			alert addAction:[
				UIAlertAction
					actionWithTitle:NSLocalizedString(@"OK", @"confirm")
					style:UIAlertActionStyleCancel
					handler:^(UIAlertAction * _Nonnull action) {
						// invoke custom handler
						handler();


		    		// important to hide the window after work completed.
		    		// this also keeps a reference to the window until the action is invoked.
		    		topWindow.hidden = YES; // if you want to hide the topwindow then use this
		    		topWindow = nil; // if you want to remove the topwindow then use this
					}
				]
		];

		[topWindow makeKeyAndVisible];
		[topWindow.rootViewController presentViewController:alert animated:YES completion:nil];
	});
};

@end
