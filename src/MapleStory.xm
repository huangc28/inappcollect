#import "../../SharedLibraries/Alert.h"
#import "AlertViewController.h"

%group MaplestoryGroup

%hook APMProductsRequest
- (void)productsRequest:(id)arg1 didReceiveResponse:(id)arg2{
	NSLog(@"DEBUG* APMProductsRequest didReceiveResponse");

	%orig;
}
%end

%hook AppleManager
- (void)productsRequest:(id)arg1 didReceiveResponse:(id)arg2{
	NSLog(@"DEBUG* AppleManager didReceiveResponse");

	%orig;
}
%end

%hook FBSDKPaymentProductRequestor
- (void)productsRequest:(id)arg1 didReceiveResponse:(id)arg2{
	@try {
		dispatch_async(dispatch_get_main_queue(), ^{
				AlertViewController *avc = [[AlertViewController alloc] init];
				[avc render];
		});
	} @catch (NSException *exception) {
		NSLog(@"DEBUG* alert exception %@", exception);
	}

	%orig;
}
%end

%hook RSInterface
- (void)productsRequest:(id)arg1 didReceiveResponse:(id)arg2{
	NSLog(@"DEBUG* RSInterface didReceiveResponse");

	%orig;
}
%end

%hook SDKWrapper
- (void)productsRequest:(id)arg1 didReceiveResponse:(id)arg2{
	NSLog(@"DEBUG* SDKWrapper didReceiveResponse");

	%orig;
}
%end

%end

extern "C" void InitMaplestoryGroup() {
	%init(MaplestoryGroup);
}
