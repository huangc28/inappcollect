#import "SpringBoard/SpringBoard.h"
#import "StoreKit/StoreKit.h"
#import "FrontBoard/FBProcess.h"

#import "Arknights/StoreKitManager.h"
#import "Arknights/U8SDKAppController.h"
#import "Arknights/StoreKitReceiptRequest.h"
#import "Arknights/StoreKitReceiptRefresher.h"
#import "Arknights/XDGProductQuery.h"
#import "Arknights/U8ProductInfo.h"

#import "SharedLibraries/HttpUtil.h"

#import "GameData.h"
#import "ClassUtil.h"
#import "Alert.h"

%group Hooks
%hook NSData

+(id)dataWithContentsOfURL:(id)arg1 {
	NSLog(@"DEBUG* dataWithContentsOfURL %@", arg1);

	NSString *sourceString = [[NSThread callStackSymbols] objectAtIndex:1];
	NSCharacterSet *separatorSet = [NSCharacterSet characterSetWithCharactersInString:@" -[]+?.,"];
	NSMutableArray *array = [NSMutableArray arrayWithArray:[sourceString  componentsSeparatedByCharactersInSet:separatorSet]];
	[array removeObject:@""];

	//NSLog(@"DEUBG* Stack = %@", [array objectAtIndex:0]);
	//NSLog(@"DEBUG* Framework = %@", [array objectAtIndex:1]);
	//NSLog(@"DEBUG* Class caller = %@", [array objectAtIndex:3]);
	//NSLog(@"DEBUG* Function caller = %@", [array objectAtIndex:4]);

	return %orig;
}

%end

%hook StoreKitManager

// We assume that when user has completed the payment, this method will be called.
// We will inspect the transaction result here and try to retrieve.
- (void)paymentQueue:(SKPaymentQueue *)arg1 updatedTransactions:(NSArray *)transactions {
	%orig;
}
%end

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
												message: @"collect complete"
										];
									} else {
										if ([errCode isEqualToString:@"1000001"]) {
											[
												Alert
													show:^(){
														NSLog(@"DEBUG* hello bryan");
													}
													title: @"Notice"
													message: @"product data already exists"
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
								}
    ];
	} @catch (NSException *exception) {
		NSLog(@"DEBUG* exception %@", exception.reason);
	}

  %orig;
}
- (_Bool)isNativePlugin { %log; _Bool r = %orig; NSLog(@" = %d", r); return r; }
- (void)submitGameData:(id)arg1 {
		NSLog(@"DEBUG submitGameData ");
		%orig;
}
- (void)showAccountCenter { %log; %orig; }
- (_Bool)hasAccountCenter { %log; _Bool r = %orig; NSLog(@" = %d", r); return r; }
- (void)switchAccount { %log; %orig; }
- (void)logout { %log; %orig; }
- (void)login {
		NSLog(@"DEBUG* login~");

		%orig;
}
- (void)didReceiveRemoteNotification:(id)arg1 { %log; %orig; }
- (void)didReceiveLocalNotification:(id)arg1 { %log; %orig; }
- (void)didFailToRegisterForRemoteNotificationsWithError:(id)arg1 { %log; %orig; }
- (void)didRegisterForRemoteNotificationsWithDeviceToken:(id)arg1 { %log; %orig; }
- (void)applicationWillTerminate:(id)arg1 { %log; %orig; }
- (void)applicationDidBecomeActive:(id)arg1 { %log; %orig; }
- (void)applicationWillEnterForeground:(id)arg1 { %log; %orig; }
- (void)applicationDidEnterBackground:(id)arg1 { %log; %orig; }
- (void)applicationWillResignActive:(id)arg1 { %log; %orig; }
- (void)application:(id)arg1 didFinishLaunchingWithOptions:(id)arg2 { %log; %orig; }
- (_Bool)application:(id)arg1 openURL:(id)arg2 options:(id)arg3 { %log; _Bool r = %orig; NSLog(@" = %d", r); return r; }
- (_Bool)application:(id)arg1 handleOpenURL:(id)arg2 { %log; _Bool r = %orig; NSLog(@" = %d", r); return r; }
- (_Bool)application:(id)arg1 openURL:(id)arg2 sourceApplication:(id)arg3 annotation:(id)arg4 { %log; _Bool r = %orig; NSLog(@" = %d", r); return r; }
- (void)setupWithParams:(id)arg1 { %log; %orig; }
- (id)initWithParams:(id)arg1 { %log; id r = %orig; NSLog(@" = %@", r); return r; }

%end // U8SDK_XD

// Detect application launch.
// Reference github: https://github.com/Razzile/RippleBoard/blob/master/Tweak.xm
// bundleIdentifier:
//   明日方舟: tw.txwy.ios.arknights
//   天堂2m :
%hook SBMainWorkspace

-(void)applicationProcessDidLaunch:(FBProcess *)applicationProcess {
    GameData *gameData = [GameData sharedInstance];
    NSLog(@"DEBUG* applicationProcessDidLaunch 1 %@", gameData);
    gameData.bundleID = applicationProcess.bundleIdentifier;

    NSLog(@"DEBUG* applicationProcessDidLaunch 2 %@", [gameData bundleID]);
    %orig;
}

%end // SBMainWorkspace
%end // Hooks

// %ctor gets called when executable is loaded into the memory
%ctor {
	NSLog(@"DEBUG* ctor!");

	%init(Hooks);
}
