#import "ProductInfoDelegate.h"

@implementation ProductInfoDelegate

- (void)validateProductIdentifiers:(NSString *)prodID {
	// NSLog(@"DEBUG* prodIDs %@", prodIDs);

	//SKProductsRequest *productsRequest = [[SKProductsRequest alloc]
        //initWithProductIdentifiers:[NSSet setWithArray:prodIDs]];

	self.request = [[SKProductsRequest alloc]
        initWithProductIdentifiers:[NSSet setWithObject:prodID]];
	self.request.delegate = self;
	[self.request start];

	NSLog(@"DEBUG* request started");
}

#pragma mark -
#pragma mark SKProductsRequestDelegate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {

	NSLog(@"DEBUG* productsRequest");
	NSLog(@"DEBUG* response %@", response);
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
	NSLog(@"DEBUG* error %@", error);
}

- (void)requestDidFinish:(SKRequest *)request {
	NSLog(@"DEBUG* requestDidFinish");
}

@end
