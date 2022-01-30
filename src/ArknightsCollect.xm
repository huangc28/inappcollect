#import "Arknights/U8ProductInfo.h"

#import "SharedLibraries/Alert.h"
#import "SharedLibraries/HttpUtil.h"
#import "CollectorCore.h"

%group ArknightsGroup

%hook U8SDK_XD
- (void)pay:(U8ProductInfo *)arg1 {
	// We can retrieve U8ProductInfo here.
	U8ProductInfo * prodInfo = (U8ProductInfo *)arg1;
	HttpUtil *httpUtil = [HttpUtil sharedInstance];
	NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];

	[
		collector
			collect :prodInfo.productId
			bundleID:bundleIdentifier
			prodName:prodInfo.productName
			prodDesc:prodInfo.productDesc
			price   :prodInfo.price
			quantity:prodInfo.buyNum
	];

	%orig;
}
%end // U8SDK_XD

%end

extern "C" void InitArknightsGroup() {
	%init(ArknightsGroup);
}
