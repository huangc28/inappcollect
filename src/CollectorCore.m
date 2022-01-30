#import "CollectorCore.h"
#import "SharedLibraries/HttpUtil.h"
#import "SharedLibraries/Alert.h"


@implementation CollectorCore

+ (instancetype)sharedInstance {
	static CollectorCore *instance = nil;
	static dispatch_once_t onceToken;

	dispatch_once(&onceToken, ^{
	    instance = [[CollectorCore alloc]init];
			instance.collectedProds = [[NSMutableDictionary alloc] init];
	});

	return instance;
}

- (void)collect:(NSString *)prodID
	bundleID:(NSString *)bundleID
	prodName:(NSString *)prodName
	prodDesc:(NSString *)prodDesc
	price   :(NSNumber *)price
	quantity:(long long)quantity {
		@try {
			CollectorCore * __weak weakSelf = self;

			HttpUtil *httpUtil = [HttpUtil sharedInstance];
			[
				httpUtil
					collectInGameProductData:prodID
						bundleID        :bundleID
						prodName        :prodName
						prodDesc        :prodDesc
						price           :price
						quantity        :quantity
						completedHandler:^(NSData *data, NSURLResponse *response, NSError *error){
							NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;

							NSError *parseError = nil;
							NSDictionary *responseDictionary = [
								NSJSONSerialization
									JSONObjectWithData:data
									options:0
									error:&parseError
							];

							NSLog(@"DEBUG* responseDictionary %@", responseDictionary);

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
								if (![responseDictionary[@"err_code"] isEqual:@"1000001"]) {
									[weakSelf unmarkCollectedProdToDictionary:prodID];
								}

								[
									Alert
										show:^(){}
										title: @"Error"
										message: responseDictionary[@"err"]
								];
							}
						}
			];
		} @catch (NSException *exception) {
			NSLog(@"DEBUG* failed to collect");
		}
}

- (void)markCollectedProdToDictionary:(NSString *)prodID {
	self.collectedProds[prodID] = @YES;
}

- (void)unmarkCollectedProdToDictionary:(NSString *)prodID {
	self.collectedProds[prodID] = @NO;
}

- (_Bool)hasProdCollected:(NSString *)prodID {
	return [self.collectedProds objectForKey:prodID] != nil && [self.collectedProds[prodID] intValue] == 1;
}

@end
