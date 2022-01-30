#import "StoreKit/StoreKit.h"

#import "SharedLibraries/HttpUtil.h"
#import "SharedLibraries/Alert.h"
#import "CollectorCore.h"

// #import "RequestCompletedHandler.h"

%group Lineage2MGroup

%hook AppleInAppPurchaseManager
// TODO Find a way to filter those products that has already been collected to prevent redundant request
// TODO check the payment status before collecting product info.
// fired to the backend.
- (void)productsRequest:(SKProductsRequest *)arg1 didReceiveResponse:(SKProductsResponse *)response {

	if ([response.products count] <= 0) {
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

extern "C" void InitLineage2MGroup() {
	%init(Lineage2MGroup);
}
