#import "StoreKit/StoreKit.h"

#import "SharedLibraries/HttpUtil.h"
#import "SharedLibraries/Alert.h"

#import "RequestCompletedHandler.h"

%group Lineage2Group

%hook AppleInAppPurchaseManager
// TODO Find a way to filter those products that has already been collected to prevent redundant request
// TODO check the payment status before collecting product info.
// fired to the backend.
- (void)productsRequest:(SKProductsRequest *)arg1 didReceiveResponse:(SKProductsResponse *)response {

	SKProduct *prod = response.products[0];

  NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];

	HttpUtil *httpUtil = [HttpUtil sharedInstance];
	[
		httpUtil
			collectInGameProductData:prod.productIdentifier
				bundleID:bundleIdentifier
				prodName:prod.localizedTitle
				prodDesc:prod.localizedDescription
					 price:prod.price
				quantity:1
        completedHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
					// If exists, we do nothing.
					// Other wise display popup showing product info exists.

					NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;

					NSError *parseError = nil;
					NSDictionary *responseDictionary = [
						NSJSONSerialization
							JSONObjectWithData:data
							options:0
							error:&parseError
					];

					if (error) {
						[
							Alert
								show:^(){
									NSLog(@"DEBUG* api request error");
								}
								title: @"Request error"
								message: [error localizedDescription]
						];
					}

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

					NSLog(@"DEBUG* The response is - %@", responseDictionary);

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
									NSLog(@"DEBUG* hello bryan");
								}
								title: @"Error"
								message: responseDictionary[@"err"]
						];
					}
				}
	];

	%orig;
}
%end

%end

extern "C" void InitLineage2Group() {
	%init(Lineage2Group);
}
