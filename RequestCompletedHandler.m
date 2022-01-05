#import "Foundation/Foundation.h"

#import "SharedLibraries/Alert.h"
#import "RequestCompletedHandler.h"

@implementation RequestCompletedHandler
+ (void) prodCollectRequestHandler:(NSData *)data response:(NSURLResponse *)response error:(NSError *)error {
	if (error) {
		[
			Alert
				show:^(){
					NSLog(@"DEBUG* item data collected!");
				}
				title: @"Error"
				message: [error localizedDescription]
		];
	}

	NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;

	NSError *parseError = nil;
	NSDictionary *responseDictionary = [
		NSJSONSerialization
			JSONObjectWithData:data
			options:0
			error:&error
	];

	if (parseError) {
		[
			Alert
				show:^(){
					NSLog(@"DEBUG* item data collected!");
				}
				title: @"Error"
				message: [parseError localizedDescription]
		];
	}

	NSLog(@"DEBUG* The response is - %@", responseDictionary);
	NSString *errCode = (NSString *)responseDictionary[@"err_code"];

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
		if ([errCode isEqualToString:@"1000001"]) {
			NSLog(@"DEBUG* product exists");
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

};
@end

