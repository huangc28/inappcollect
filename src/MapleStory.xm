#import "StoreKit/StoreKit.h"

#import "../../SharedLibraries/Alert.h"
#import "../../SharedLibraries/AlertViewController.h"
#import "../UncleTuuCollectorCore/CollectorCore.h"

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
- (void)productsRequest:(id)arg1 didReceiveResponse:(SKProductsResponse *)response{
	@try {
		if ([response.products count] <= 0) {
			%orig;

			return;
		}

		SKProduct *prod = response.products[0];
		NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];

		CollectorCore *collector = [CollectorCore sharedInstance];

		// if product info has been collected, skip API request.
		if ([collector hasProdCollected:prod.productIdentifier] == NO) {
			[collector markCollectedProdToDictionary:prod.productIdentifier];

			[
				collector
					collectWithCustomedAlert :prod.productIdentifier
					bundleID                 :bundleIdentifier
					prodName                 :prod.localizedTitle
					prodDesc                 :prod.localizedDescription
					price					 :prod.price
					quantity				 :1
			];
		}

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
