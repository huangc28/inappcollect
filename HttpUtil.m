#import "Foundation/Foundation.h"
#import "U8ProductInfo.h"
#import "HttpUtil.h"

//  Parameter to pass to collect in game product method.
//   - productID
//   - productName
//   - productDesc
//   - quantity
//   - roleId
//   - roleName

// Singleton implementation:
// https://zonble.gitbooks.io/kkbox-ios-dev/content/design_patterns/singleton.html
// @TODO:
//   - apiBaseurl 
@implementation HttpUtil
+ (instancetype) sharedInstance {
    static HttpUtil *instance = nil;
    static dispatch_once_t onceToken;
    
    NSString *apiBaseURL = @"http://192.168.50.94:3009";
    
    dispatch_once(&onceToken, ^{
        instance = [[HttpUtil alloc]init];
        [instance setBaseURL: apiBaseURL];
    });
    
    return instance;
}

- (void) setBaseURL:(NSString *)url {
    self.apiBaseURL = url;
} 


// @TODO pass block as variable.
// POST following info to backend:
//   - productID
//   - productName
//   - productDesc
//   - quantity
//   - roleId
//   - roleName
//
- (NSURLSessionDataTask *)collectInGameProductData:(NSString *)prodID
bundleID:(NSString *)bundleID
prodName:(NSString *)prodName  
prodDesc:(NSString *)prodDesc
price:(NSNumber *) price
quantity:(long long)quantity
completedHandler:(completedHandler)completedHandler
{
    NSLog(@"DEBUG* bundleID %@", bundleID);
    NSLog(@"DEBUG* prodID %@", prodID);
    NSLog(@"DEBUG* prodName %@", prodName);
    NSLog(@"DEBUG* prodDesc %@", prodDesc);
    NSLog(@"DEBUG* price %@", price);
    NSLog(@"DEBUG* quantity %lld", quantity);

    NSString *params = [ 
        NSString stringWithFormat: @"bundle_id=%@&prod_id=%@&prod_name=%@&prod_desc=%@&price=%@&quantity=%lld", bundleID, prodID, prodName, prodDesc, price, quantity
    ];
    
    // Convert string to data
    NSData *postData = [
        params 
            dataUsingEncoding:NSUTF8StringEncoding
            allowLossyConversion:YES
    ]; 

    NSString *paramsLength = [
        NSString stringWithFormat: @"%d", (int)[postData length]
    ];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    

    // Combine API endpoint
    // http://localhost:3009/v1/collect
    NSString * apiEndpoint = [
        NSString stringWithFormat:@"%@/v1/collect-product-info", self.apiBaseURL
    ];

    [request setURL:[NSURL URLWithString:apiEndpoint]];    
    [request setHTTPMethod: @"POST"];
    [request setValue: paramsLength forHTTPHeaderField: @"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type" ];
    [request setHTTPBody:postData];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [
        session 
            dataTaskWithRequest: request
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                completedHandler(data, response, error);

            }
    ];
    
    [dataTask resume];
    
    return dataTask;
}
- (void)vendorBuyInGameProductData {
    NSLog(@"DEBUG* vendorBuyInGameProductData");
}
- (void)exportItemToCustomerFromStoreHouse {
    NSLog(@"DEBUG* exportItemToCustomerFromStoreHouse");
}
@end

