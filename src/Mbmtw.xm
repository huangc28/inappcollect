#import "StoreKit/StoreKit.h"

#import "../UncleTuuCollectorCore/CollectorCore.h"

%group MbmtwGroup
%hook BTPayment
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
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
				collect :prod.productIdentifier
				bundleID:bundleIdentifier
				prodName:prod.localizedTitle
				prodDesc:prod.localizedDescription
				price   :prod.price
				quantity:1
		];
	}

	%orig;
}
%end
%end

extern "C" void InitMbmtwGroup() {
	%init(MbmtwGroup);
}
