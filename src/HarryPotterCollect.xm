#import "StoreKit/StoreKit.h"

#import "../UncleTuuCollectorCore/CollectorCore.h"

%group HarryPotterGroup
%hook FBSDKPaymentProductRequestor
- (void)productsRequest:(id)arg1 didReceiveResponse:(SKProductsResponse *)response {
	if ([response.products count] <= 0) {
		%orig;

		return;
	}

	SKProduct *prod = response.products[0];
	NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];

	NSLog(@"DEBUG* HarryPotterGroup FBSDKPaymentProductRequestor bundleIdentifier 1 %@", bundleIdentifier);
	// Perform operation only if bundleIdentifier equals
	if ([bundleIdentifier isEqual:@"com.netease.harrypotter.tw"]) {
		NSLog(@"DEBUG* HarryPotterGroup FBSDKPaymentProductRequestor productsRequest 2 ~");
		CollectorCore *collector = [CollectorCore sharedInstance];

		// if product info has been collected, skip API request.
		if ([collector hasProdCollected:prod.productIdentifier] == NO) {
			[collector markCollectedProdToDictionary:prod.productIdentifier];

			[
				collector
					collect :prod.productIdentifier
					bundleID:bundleIdentifier
					prodName:prod.localizedTitle
					prodDesc:prod.localizedDescription
					price   :prod.price
					quantity:1
			];
		}
	}


	%orig;
}
%end
%end

extern "C" void InitHarryPotterGroup() {
	%init(HarryPotterGroup);
}
