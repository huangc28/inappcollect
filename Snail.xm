#import "StoreKit/StoreKit.h"

#import "SharedLibraries/Alert.h"
#import "SharedLibraries/HttpUtil.h"

%group Snail
%hook PayModule
- (void)productsRequest:(SKProductsRequest *)arg1 didReceiveResponse:(SKProductsResponse *)response {

	SKProduct *prod = response.products[0];
  NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
  HttpUtil *httpUtil = [HttpUtil sharedInstance];

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

					NSLog(@"DEBUG* The response is - %@", responseDictionary);
					NSString *errCode = (NSString *)responseDictionary[@"err_code"];

					if (httpResponse.statusCode == 200) {
						[
							Alert
								show:^(){
									NSLog(@"DEBUG* item data collected!");
								}
								title: @"Success"
								message: @"採集成功"
						];
					} else {
						if ([errCode isEqualToString:@"1000001"]) {
							NSLog(@"DEBUG* product exists %@", prod.localizedTitle);
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
				}
	];

	%orig;
}

%end
%end

extern "C" void InitSnail() {
	%init(Snail);
}
