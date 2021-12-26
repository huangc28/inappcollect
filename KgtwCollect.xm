#import "StoreKit/StoreKit.h"

#import "SharedLibraries/HttpUtil.h"
#import "SharedLibraries/Alert.h"

%group KgtwCollect

%hook BTPayment

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
  for (SKPaymentTransaction *transaction in transactions) {
		switch (transaction.transactionState) {
			case SKPaymentTransactionStatePurchasing: {
				NSLog(@"DEBUG* SKPaymentTransactionStatePurchasing");
			}
		}
	}

	%orig;
}

- (void)productsRequest:(SKProductsRequest *)arg1 didReceiveResponse:(SKProductsResponse *)response {
	NSUInteger prodCount = [response.products count];

	if (prodCount > 0) {
		SKProduct *prod = response.products[0];

		// Collect product data.
		NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
		HttpUtil *httpUtil = [HttpUtil sharedInstance];

		// TODO: Extract completed handler (duplicated in logic) to independent block.
		[
			httpUtil
				collectInGameProductData: prod.productIdentifier
												bundleID: bundleIdentifier
												prodName: prod.localizedTitle
												prodDesc: prod.localizedDescription
													 price: prod.price
												quantity: 1
								completedHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
									NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;

									NSError *parseError = nil;
									NSDictionary *responseDictionary = [
										NSJSONSerialization
											JSONObjectWithData:data
											options:0
											error:&parseError
									];

									if (parseError) {
										[
											Alert
												show:^(){
													NSLog(@"DEBUG* failed to parsed request");
												}
												title: @"Response parse error"
												message: [parseError localizedDescription]
										];
									}

									if (httpResponse.statusCode == 200) {
										[
											Alert
												show:^(){
													NSLog(@"DEBUG* item data collected!");
												}
												title: @"Success"
												message: @"collect complete"
										];
									} else {
										[
											Alert
												show:^(){
													NSLog(@"DEBUG* failed to collect product data");
												}
												title: @"Error"
												message: responseDictionary[@"err"]
										];
									}
								}
		];
	}

	%orig;
}

%end

%hook FBSDKPaymentObserver

- (void)paymentQueue:(SKPaymentQueue *)arg1 updatedTransactions:(NSArray *)arg2 {
	NSLog(@"DEBUG* FBSDKPaymentObserver paymentQueue");

	%orig;
}

%end

%hook FIRAInAppPurchaseTransactionReporter

- (void)paymentQueue:(SKPaymentQueue *)arg1 updatedTransactions:(NSArray *)arg2 {
	NSLog(@"DEBUG* FIRAInAppPurchaseTransactionReporter paymentQueue");

	%orig;
}

%end

%end

// 傳說對決
extern "C" void InitKgtwCollect() {
	%init(KgtwCollect)
}
