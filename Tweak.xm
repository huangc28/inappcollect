#import "SpringBoard/SpringBoard.h"
#import "StoreKit/StoreKit.h"
#import "FrontBoard/FBProcess.h"

#import "Arknights/StoreKitManager.h"
#import "Arknights/U8SDKAppController.h"
#import "Arknights/StoreKitReceiptRequest.h"
#import "Arknights/StoreKitReceiptRefresher.h"
#import "Arknights/XDGProductQuery.h"


#import "HttpUtil.h"
#import "GameData.h"
#import "ClassUtil.h"
#import "Alert.h"

%group Hooks

%hook XDGProductQuery
- (void)queryTransactionReceipt:(id)arg1 withCompletion:(id)arg2 {
	NSLog(@"DEBUG* queryTransactionReceipt 1 %@", arg1);
	NSLog(@"DEBUG* queryTransactionReceipt 2 %@", arg2);

	Method m = class_getClassMethod( [ self class ], @selector(queryTransactionReceipt));
	char ret[ 256 ];
	method_getReturnType( m, ret, 256 );
	// NSLog( @"DEBUG* Return type: %s", ret );

	NSLog(@"DEUBG* Stack = %@", [array objectAtIndex:0]);
	NSLog(@"DEBUG* Framework = %@", [array objectAtIndex:1]);
	NSLog(@"DEBUG* Class caller = %@", [array objectAtIndex:3]);
	NSLog(@"DEBUG* Function caller = %@", [array objectAtIndex:4]);

	// %orig;
}
%end

%hook APMInAppPurchaseTransactionReporter
- (void)reportTransactionsFromArray:(id)arg1 {
	NSLog(@"DEBUG* reportTransactionsFromArray 1 %@", arg1);

	// %orig;
}
%end

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


%hook StoreKitReceiptRefresher
- (void)refreshReceipt {
	NSLog(@"DEBUG* refreshReceipt");
}

- (void)requestDidFinish:(id)arg1 {
	NSLog(@"DEBUG* requestDidFinish %@", arg1);
}
%end

%hook StoreKitReceiptRequest
- (void)validateReceipt:(id)arg1 {
	NSLog(@"DEBUG* validateReceipt %@", arg1);
}
%end

%hook U8SDKAppController

- (void)OnPayPaid:(id)arg1{
	NSLog(@"DEBUG* OnPayPaid~ %@", arg1);

	%orig;
}
%end


%hook StoreKitManager
- (void)setDeferredPayment:(SKPayment *)deferredPayment { %log; %orig; }
- (SKPayment *)deferredPayment { %log; SKPayment * r = %orig; NSLog(@"DEBUG* = %@", r); return r; }
- (void)setApplicationUserName:(NSString *)applicationUserName { %log; %orig; }
- (NSString *)applicationUserName { %log; NSString * r = %orig; NSLog(@"DEBUG* = %@", r); return r; }
- (void)setCurrentTransactions:(NSMutableArray *)currentTransactions { %log; %orig; }
- (NSMutableArray *)currentTransactions { %log; NSMutableArray * r = %orig; NSLog(@"DEBUG* = %@", r); return r; }
- (void)setProducts:(NSArray *)products { %log; %orig; }
- (NSArray *)products {
    NSArray * r = %orig;

    NSLog(@"DEBUG* setProducts = %@", r);

    return r;
}
- (void)productViewControllerDidFinish:(id)arg1 {
    NSLog(@"DEBUG* productViewControllerDidFinish !");


    %orig;
}
- (void)storeKitReceiptRequest:(id)arg1 validatedWithStatusCode:(int)arg2 {
		NSLog(@"DEBUG* storeKitReceiptRequest 1 %@, %d", arg1, arg2);

		%orig;
}
- (void)storeKitReceiptRequest:(id)arg1 validatedWithResponse:(id)arg2 {
		NSLog(@"DEBUG* storeKitReceiptRequest %@, %@", arg1, arg2);

		%orig;
}
- (void)storeKitReceiptRequest:(id)arg1 didFailWithError:(id)arg2 { %log; %orig; }
- (void)paymentQueue:(id)arg1 updatedDownloads:(id)arg2 {
    NSLog(@"DEBUG* paymentQueue 1");

    %orig;
}
- (void)paymentQueueRestoreCompletedTransactionsFinished:(id)arg1 {
    NSLog(@"DEBUG* paymentQueueRestoreCompletedTransactionsFinished");

    %orig;
}
- (void)paymentQueue:(id)arg1 restoreCompletedTransactionsFailedWithError:(id)arg2 {
    NSLog(@"DEBUG* paymentQueue 2");

    %orig;
}
- (void)paymentQueue:(id)arg1 removedTransactions:(id)arg2 {
    NSLog(@"DEBUG* paymentQueue 3 %@", arg1);

    %orig;
}
- (_Bool)paymentQueue:(id)arg1 shouldAddStorePayment:(id)arg2 forProduct:(id)arg3 {
    _Bool r = %orig;
    NSLog(@"DEBUG* paymentQueue 4 %d", r);
    return r;
}

// We assume that when user has completed the payment, this method will be called.
// We will inspect the transaction result here and try to retrieve.
- (void)paymentQueue:(SKPaymentQueue *)arg1 updatedTransactions:(NSArray *)transactions {
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased: {
              NSLog(@"DEBUG* transaction success %@", transaction);

							NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
							NSData *receipt = [NSData dataWithContentsOfURL:receiptURL];
							if (!receipt) {
							    NSLog(@"DEBUG* no receipt");
							    /* No local receipt -- handle the error. */
							} else {
							    /* Get the receipt in encoded format */
							    NSString *encodedReceipt = [receipt base64EncodedStringWithOptions:0];

							    NSLog(@"DEBUG* encodedReceipt %@", encodedReceipt);
							}

							break;
						}

            case SKPaymentTransactionStateFailed: {

                NSLog(@"DEBUG* Transaction Failed");
                // [[SKPaymentQueue defaultQueue]
                //      finishTransaction:transaction];
                break;
						}

            default: {
							break;
						}
        }
    }

		// import (入庫): we hijack transaction `SKPaymentTransaction` instance data here!
		// assign custom data to this `SKPaymentTransaction`:
		//   - payment.productIdentifier
		//   - payment.quantity
		//   - transaction.transactionIdentifier

    // arg2 is NSArray of type SKPaymentTransaction.
    //   - product token
    //   - possibly application user
    // SKPaymentTransaction *paymentTrans = arg2[0];
    // SKPayment *payment = MSHookIvar<SKPayment *>(paymentTrans, "payment");
    // NSString *appUsername = MSHookIvar<NSString *>(payment, "applicationUsername");
    // Try iterate through all transactions
    // for


    // NSData *reqData = MSHookIvar<NSData>(skp, "requestData");
    //NSString *reqDataStr = [[NSString alloc] initWithData:reqData encoding:NSUTF8StringEncoding];

    // NSLog(@"DEBUG* arg2 size %lu %lu", sizeof(arg2), (unsigned long)[arg2 count]);
    for (SKPaymentTransaction *transaction in transactions) {
        NSLog(@"DEBUG* iter");
        SKPayment *payment = transaction.payment;

        NSString *productIdentifier = payment.productIdentifier;
        NSInteger quantity = payment.quantity;

        NSLog(@"DEBUG* paymentQueue transaction transactionIdentifier %@", transaction.transactionIdentifier);
        NSLog(@"DEBUG* paymentQueue productIdentifier %@", productIdentifier);
        NSLog(@"DEBUG* paymentQueue quantity %ld", (long)quantity);
    }

    // NSLog(@"DEBUG* paymentTrans %@", paymentTrans);

    %orig;
}
- (void)request:(id)arg1 didFailWithError:(id)arg2 {
    NSLog(@"DEBUG* request");

    %orig;
 }
- (void)productsRequest:(id)arg1 didReceiveResponse:(id)arg2 {
    NSLog(@"DEBUG* productsRequest");

    %orig;
}
- (void)displayStoreWithProductId:(id)arg1 affiliateToken:(id)arg2 {
    NSLog(@"DEBUG* displayStoreWithProductId");

    %orig;
}
- (void)cancelDownloads { %log; %orig; }
- (void)resumeDownloads { %log; %orig; }
- (void)pauseDownloads { %log; %orig; }
- (void)updateStorePromotionVisibility:(long long)arg1 forProductId:(id)arg2 { %log; %orig; }
- (void)fetchStorePromotionVisibilityForProductId:(id)arg1 { %log; %orig; }
- (id)getAllCurrentTransactions {
		id r = %orig;
		NSLog(@"DEBUG* getAllCurrentTransactions %@", r);
		return r;
}
- (id)getAllSavedTransactions { %log; id r = %orig; NSLog(@"DEBUG* getAllSavedTransactions %@", r); return r; }
- (void)validateAutoRenewableReceipt:(id)arg1 withSecret:(id)arg2 isTestReceipt:(_Bool)arg3 { %log; %orig; }
- (void)validateReceipt:(id)arg1 isTestReceipt:(_Bool)arg2 {
	NSLog(@"DEBUG validate validateReceipt %@", arg1);

	%orig;
}
- (void)finishPendingTransaction:(id)arg1 { %log; %orig; }
- (void)finishPendingTransactions { %log; %orig; }
- (void)purchaseProduct:(id)arg1 quantity:(int)arg2 {
    NSLog(@"DEBUG* purchaseProduct");

    %orig;
}
- (_Bool)canMakePayments { %log; _Bool r = %orig; NSLog(@"DEBUG* canMakePayments %d", r); return r; }
- (void)requestProductData:(id)arg1 {
    NSLog(@"DEBUG* requestProductData");

    %orig;
}
- (id)productForIdentifier:(id)arg1 { %log; id r = %orig; NSLog(@"DEBUG* productForIdentifier %@", r); return r; }
- (void)unitySendErrorMessage:(unsigned int *)arg1 error:(id)arg2 { %log; %orig; }
- (void)completeAndRecordTransaction:(id)arg1 {
	NSLog(@"DEBUG* completeAndRecordTransaction %@", arg1);

	%orig;
}
- (id)init { id r = %orig; return r;}
- (NSString *)debugDescription { %log; NSString * r = %orig; NSLog(@"DEBUG* debugDescription = %@", r); return r; }
- (NSString *)description { %log; NSString * r = %orig; NSLog(@"DEBUG* description %@", r); return r; }
- (NSUInteger )hash { %log; NSUInteger  r = %orig; NSLog(@"DEBUG* hash %lu", (unsigned long)r); return r; }
- (Class )superclass { %log; Class  r = %orig; NSLog(@"DEBUG* superclass %@", r); return r; }
%end

%hook UnityView

- (void)touchesEnded:(id)arg1 withEvent:(id)arg2{

	//[
	//	[ClassUtil sharedInstance]
	//		dumpClassInfo:[XDGProductQuery class]
	//];

	// [
	// 	[ClassUtil sharedInstance]
	// 		dumpClassInfo:FBSDKPaymentProductRequester
	// ];

	// [
	// 	[ClassUtil sharedInstance]
	// 		dumpClassInfo:APMInAppPurchaseTransactionReporter
	// ];

	%orig;
}

- (void)touchesBegan:(id)arg1 withEvent:(id)arg2{
		// Code to invoke payment.
    // SKMutablePayment *payment = [[SKMutablePayment alloc] init] ;
    // payment.productIdentifier = @"arktw_diamond_1";
    // [[SKPaymentQueue defaultQueue] addPayment:payment];

		// ClassUtil

    %orig;
}

%end

%hook U8SDK_XD

- (id)dicWithJsonStr:(id)arg1 { %log; id r = %orig; NSLog(@" = %@", r); return r; }
- (void)txwyPassportUpdated { %log; %orig; }
- (void)txwyPayCancelled { %log; %orig; }
// This method gets trigger when user completes the payment.
// I should be able to retrieve transaction ID.
// If %orig doesn't invoke, the item will not be updated. That means
// this method handles the update of in app item.
- (void)txwyDidPay:(SKPaymentTransaction *)arg1 {
    NSLog(@"DEBUG* txwyDidPay %@", arg1);

    NSLog(@"DEBUG* txwyDidPay 2 %@", arg1.transactionIdentifier);
    NSLog(@"DEBUG* txwyDidPay 3 %ld", (long)arg1.transactionState);
    // NSString *receipt = [[NSString alloc] initWithData:arg1.transactionReceipt encoding:NSUTF8StringEncoding];
    // NSLog(@"DEBUG* txwyDidPay 4 %@", receipt);

    %orig;
}
- (void)txwyDidPassport { %log; %orig; }
- (const char *)getData:(int)arg1 withParams:(id)arg2 {
    const char * r = %orig;
    NSLog(@" = 0x%s", r);
    return r;
}
- (void)setData:(int)arg1 withParams:(id)arg2 {
	%orig;
}
- (void)pay:(U8ProductInfo *)arg1 {
    // We can retrieve U8ProductInfo here.
    U8ProductInfo * prodInfo = (U8ProductInfo *)arg1;
    HttpUtil *httpUtil = [HttpUtil sharedInstance];

    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];


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
													NSLog(@"DEBUG* hello bryan!!");
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
//   StoreKit:
//   明日方舟: tw.txwy.ios.arknights
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
