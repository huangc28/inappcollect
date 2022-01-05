#import "Foundation/Foundation.h"
#import "StoreKit/StoreKit.h"

@interface ProductInfoDelegate : NSObject<SKProductsRequestDelegate> {
	SKProductsRequest *_request;
	NSArray *_products;
}

@property(strong, nonatomic) SKProductsRequest *request; //@synthesize request=_request
@property(strong, nonatomic) NSArray *products; //@synthesize products=_products

- (void)validateProductIdentifiers:(NSString *)prodID;

@end
