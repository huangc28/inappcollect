#import "StoreKit/StoreKit.h"
#import "FrontBoard/FBProcess.h"
#import "StoreKitManager.h"
#import "U8ProductInfo.h"
#import "HttpUtil.h"

%group Hooks

%hook StoreKitManager
+ (void)unitySendMessage:(id)arg1 param:(id)arg2 { %log; %orig; }
+ (id)sharedManager { 
    id r = %orig; 

    return r; 
 }
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
- (void)storeKitReceiptRequest:(id)arg1 validatedWithStatusCode:(int)arg2 { %log; %orig; }
- (void)storeKitReceiptRequest:(id)arg1 validatedWithResponse:(id)arg2 { %log; %orig; }
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
    NSLog(@"DEBUG* paymentQueue 3");

    %orig; 
}
- (_Bool)paymentQueue:(id)arg1 shouldAddStorePayment:(id)arg2 forProduct:(id)arg3 { 
    _Bool r = %orig; 
    NSLog(@"DEBUG* paymentQueue 4 %d", r); 
    return r;
}
- (void)paymentQueue:(SKPaymentQueue *)arg1 updatedTransactions:(NSArray *)arg2 { 
    NSLog(@"DEBUG* paymentQueue 5 - 1 %@", arg1); 
    NSLog(@"DEBUG* paymentQueue 5 - 2 %@", arg2[0]); 
    
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

    NSLog(@"DEBUG* arg2 size %lu %lu", sizeof(arg2), (unsigned long)[arg2 count]);
    //for (id arg in arg2) {
    //    NSLog(@"DEBUG* iter"); 
    //    SKPaymentTransaction *paymentTrans = (SKPaymentTransaction *)arg;
    //    SKPayment *payment = paymentTrans.payment;


    //    NSString *appUsername = payment.applicationUsername;
    //    NSString *productIdentifier = payment.productIdentifier;
    //    NSInteger quantity = payment.quantity;

    //    // These data aren't avaiable in this game.
    //    // NSData *reqData = payment.requestData;
    //    // NSString *reqDataStr = [[NSString alloc] initWithData:reqData encoding:NSASCIIStringEncoding];

    //    // NSLog(@"DEBUG* appUsername %@", appUsername);
    //    // NSLog(@"DEBUG* productIdentifier %@", productIdentifier);
    //    // NSLog(@"DEBUG* quantity %ld", (long)quantity);

    //    // We need to send these data to remote server. 
    //    
    //}

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
// 	UIAlertView *alertView = [
// 		[UIAlertView alloc] initWithTitle:@"Save" message:@"displayStoreWithProductId" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
// 
//    	alertView.alertViewStyle = UIAlertViewStylePlainTextInput;

//    [alertView show];
    NSLog(@"DEBUG* displayStoreWithProductId");

    %orig; 
}
- (void)cancelDownloads { %log; %orig; }
- (void)resumeDownloads { %log; %orig; }
- (void)pauseDownloads { %log; %orig; }
- (void)updateStorePromotionVisibility:(long long)arg1 forProductId:(id)arg2 { %log; %orig; }
- (void)fetchStorePromotionVisibilityForProductId:(id)arg1 { %log; %orig; }
- (id)getAllCurrentTransactions { %log; id r = %orig; NSLog(@"DEBUG* getAllCurrentTransactions %@", r); return r; }
- (id)getAllSavedTransactions { %log; id r = %orig; NSLog(@"DEBUG* getAllSavedTransactions %@", r); return r; }
- (void)validateAutoRenewableReceipt:(id)arg1 withSecret:(id)arg2 isTestReceipt:(_Bool)arg3 { %log; %orig; }
- (void)validateReceipt:(id)arg1 isTestReceipt:(_Bool)arg2 { %log; %orig; }
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
- (void)completeAndRecordTransaction:(id)arg1 { %log; %orig; }
- (id)init { id r = %orig; return r;}
- (NSString *)debugDescription { %log; NSString * r = %orig; NSLog(@"DEBUG* debugDescription = %@", r); return r; }
- (NSString *)description { %log; NSString * r = %orig; NSLog(@"DEBUG* description %@", r); return r; }
- (NSUInteger )hash { %log; NSUInteger  r = %orig; NSLog(@"DEBUG* hash %lu", (unsigned long)r); return r; }
- (Class )superclass { %log; Class  r = %orig; NSLog(@"DEBUG* superclass %@", r); return r; }
%end

%hook UnityView

- (void)touchesEnded:(id)arg1 withEvent:(id)arg2{
    %orig;
}

- (void)touchesBegan:(id)arg1 withEvent:(id)arg2{
    %orig;
}

%end

%hook U8SDK_XD

- (id)dicWithJsonStr:(id)arg1 { %log; id r = %orig; NSLog(@" = %@", r); return r; }
- (void)txwyPassportUpdated { %log; %orig; }
- (void)txwyPayCancelled { %log; %orig; }
- (void)txwyDidPay:(id)arg1 { %log; %orig; }
- (void)txwyDidPassport { %log; %orig; }
- (const char *)getData:(int)arg1 withParams:(id)arg2 { 
    const char * r = %orig; 
    NSLog(@" = 0x%s", r); 
    return r; 
}
- (void)setData:(int)arg1 withParams:(id)arg2 { %log; %orig; }
- (void)pay:(U8ProductInfo *)arg1 { 
    // We can retrieve U8ProductInfo here.
    HttpUtil *httpUtil = [HttpUtil sharedInstance];
    
    [
        httpUtil 
            collectInGameProductData: prodInfo.productId
                // prodName: prodInfo.productName
                prodName: @"妳好雞掰"
                prodDesc: prodInfo.productDesc
                price: prodInfo.price
                quantity: prodInfo.buyNum
    ];
    

    %orig; 
}
- (_Bool)isNativePlugin { %log; _Bool r = %orig; NSLog(@" = %d", r); return r; }
- (void)submitGameData:(id)arg1 { %log; %orig; }
- (void)showAccountCenter { %log; %orig; }
- (_Bool)hasAccountCenter { %log; _Bool r = %orig; NSLog(@" = %d", r); return r; }
- (void)switchAccount { %log; %orig; }
- (void)logout { %log; %orig; }
- (void)login { %log; %orig; }
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
    NSLog(@"DEBUG* applicationProcessDidLaunch %@", applicationProcess.bundleIdentifier);

    %orig;
}

%end // SBMainWorkspace
%end // Hooks

// %ctor gets called when executable is loaded into the memory
%ctor {
	NSLog(@"DEBUG* ctor!");

	%init(Hooks);
}