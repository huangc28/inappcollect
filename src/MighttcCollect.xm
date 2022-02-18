#import "StoreKit/StoreKit.h"

#import "../UncleTuuCollectorCore/CollectorCore.h"

%group MighttcCollect
%hook InAppPurchaseController
- (void)productsRequest:(id)arg1 didReceiveResponse:(SKProductsResponse *)response {
	NSLog(@"DEBUG* InAppPurchaseController");

	NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];

	if ([bundleIdentifier isEqualToString:@"jp.co.koeitecmo.a-mighttc"]) {
		if ([response.products count] <= 0) {
			%orig;

			return;
		}

		SKProduct *prod = response.products[0];

		CollectorCore *collector = [CollectorCore sharedInstance];

		// if product info has been collected, skip API request.
		if ([collector hasProdCollected:prod.productIdentifier] == NO) {
			[collector markCollectedProdToDictionary:prod.productIdentifier];

			[
				collector
					collect									 :prod.productIdentifier
					bundleID								 :bundleIdentifier
					prodName								 :prod.localizedTitle
					prodDesc								 :prod.localizedDescription
					price   								 :prod.price
					quantity								 :1
			];
		}
	}

	%orig;
}

%end
%end


extern "C" void InitMighttcCollect() {
	%init(MighttcCollect);
}
