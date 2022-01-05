#import "Arknights/U8ProductInfo.h"

#import "SharedLibraries/Alert.h"
#import "SharedLibraries/HttpUtil.h"

%group ArknightsGroup

%hook U8SDK_XD
- (void)pay:(U8ProductInfo *)arg1 {
	@try {
    // We can retrieve U8ProductInfo here.
    U8ProductInfo * prodInfo = (U8ProductInfo *)arg1;
    HttpUtil *httpUtil = [HttpUtil sharedInstance];

    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];

		// TODO this method should be extracted to an independent class
    [
        httpUtil
            collectInGameProductData: prodInfo.productId
                bundleID: bundleIdentifier
                prodName: prodInfo.productName
                prodDesc: prodInfo.productDesc
                price: prodInfo.price
                quantity: prodInfo.buyNum
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
											NSLog(@"DEBUG* product exists %@", prodInfo.productName);
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
	} @catch (NSException *exception) {
		NSLog(@"DEBUG* exception %@", exception.reason);
	}

  %orig;
}
%end // U8SDK_XD

%end

extern "C" void InitArknightsGroup() {
	%init(ArknightsGroup);
}
