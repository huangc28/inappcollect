%group CallmeBigBossCollect

%hook APMProductsRequest
- (void)productsRequest:(id)arg1 didReceiveResponse:(id)arg2 {
	NSLog(@"DEBUG* APMProductsRequest productsRequest");

	%orig;
}
%end

%hook FBSDKPaymentProductRequestor
- (void)productsRequest:(id)arg1 didReceiveResponse:(id)arg2 {
	NSLog(@"DEBUG* FBSDKPaymentProductRequestor productsRequest");

	%orig;
}
%end

%hook RVProductManager
- (void)productsRequest:(id)arg1 didReceiveResponse:(id)arg2 {
	NSLog(@"DEBUG* RVProductManager productsRequest");

	%orig;
}
%end

%hook RVSDKProductRequest
- (void)productsRequest:(id)arg1 didReceiveResponse:(id)arg2 {
	NSLog(@"DEBUG* RVSDKProductRequest productsRequest");

	%orig;
}
%end

%end

extern "C" void InitCallmeBigBossCollect() {
	%init(CallmeBigBossCollect);
}
