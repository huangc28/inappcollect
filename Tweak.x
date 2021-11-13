#import "StoreKit/StoreKit.h"
#import "FrontBoard/FBProcess.h"

%group Hooks

%hook StoreKitManager
+ (void)unitySendMessage:(id)arg1 param:(id)arg2 { %log; %orig; }
+ (id)sharedManager { %log; id r = %orig; NSLog(@"DEBUG* sharedManager %@", r); return r; }
- (void)setDeferredPayment:(SKPayment *)deferredPayment { %log; %orig; }
- (SKPayment *)deferredPayment { %log; SKPayment * r = %orig; NSLog(@"DEBUG* = %@", r); return r; }
- (void)setApplicationUserName:(NSString *)applicationUserName { %log; %orig; }
- (NSString *)applicationUserName { %log; NSString * r = %orig; NSLog(@"DEBUG* = %@", r); return r; }
- (void)setCurrentTransactions:(NSMutableArray *)currentTransactions { %log; %orig; }
- (NSMutableArray *)currentTransactions { %log; NSMutableArray * r = %orig; NSLog(@"DEBUG* = %@", r); return r; }
- (void)setProducts:(NSArray *)products { %log; %orig; }
- (NSArray *)products { 
    NSArray * r = %orig; 

    NSLog(@"DEBUG* products = %@", r); 

    return r; 
}
- (void)productViewControllerDidFinish:(id)arg1 { 
    NSLog(@"DEBUG* productViewControllerDidFinish !");

    
    %orig; 
}
- (void)storeKitReceiptRequest:(id)arg1 validatedWithStatusCode:(int)arg2 { %log; %orig; }
- (void)storeKitReceiptRequest:(id)arg1 validatedWithResponse:(id)arg2 { %log; %orig; }
- (void)storeKitReceiptRequest:(id)arg1 didFailWithError:(id)arg2 { %log; %orig; }
- (void)paymentQueue:(id)arg1 updatedDownloads:(id)arg2 { %log; %orig; }
- (void)paymentQueueRestoreCompletedTransactionsFinished:(id)arg1 { %log; %orig; }
- (void)paymentQueue:(id)arg1 restoreCompletedTransactionsFailedWithError:(id)arg2 { %log; %orig; }
- (void)paymentQueue:(id)arg1 removedTransactions:(id)arg2 { %log; %orig; }
- (_Bool)paymentQueue:(id)arg1 shouldAddStorePayment:(id)arg2 forProduct:(id)arg3 { %log; _Bool r = %orig; NSLog(@"DEBUG* = %d", r); return r; }
- (void)paymentQueue:(id)arg1 updatedTransactions:(id)arg2 { %log; %orig; }
- (void)request:(id)arg1 didFailWithError:(id)arg2 { %log; %orig; }
- (void)productsRequest:(id)arg1 didReceiveResponse:(id)arg2 { 
    NSLog(@"DEBUG* productsRequest !");
    
    %orig; 
}
- (void)displayStoreWithProductId:(id)arg1 affiliateToken:(id)arg2 { 
	UIAlertView *alertView = [
		[UIAlertView alloc] initWithTitle:@"Save" message:@"displayStoreWithProductId" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];

   	alertView.alertViewStyle = UIAlertViewStylePlainTextInput;

    [alertView show];
    NSLog(@"DEBUG* displayStoreWithProductId");

    %orig; 
}
- (void)cancelDownloads { %log; %orig; }
- (void)resumeDownloads { %log; %orig; }
- (void)pauseDownloads { %log; %orig; }
- (void)updateStorePromotionVisibility:(long long)arg1 forProductId:(id)arg2 { %log; %orig; }
- (void)fetchStorePromotionVisibilityForProductId:(id)arg1 { %log; %orig; }
- (id)getAllCurrentTransactions { %log; id r = %orig; NSLog(@"DEBUG* = %@", r); return r; }
- (id)getAllSavedTransactions { %log; id r = %orig; NSLog(@"DEBUG* = %@", r); return r; }
- (void)validateAutoRenewableReceipt:(id)arg1 withSecret:(id)arg2 isTestReceipt:(_Bool)arg3 { %log; %orig; }
- (void)validateReceipt:(id)arg1 isTestReceipt:(_Bool)arg2 { %log; %orig; }
- (void)finishPendingTransaction:(id)arg1 { %log; %orig; }
- (void)finishPendingTransactions { %log; %orig; }
- (void)purchaseProduct:(id)arg1 quantity:(int)arg2 { %log; %orig; }
- (_Bool)canMakePayments { %log; _Bool r = %orig; NSLog(@"DEBUG* = %d", r); return r; }
- (void)requestProductData:(id)arg1 {  
    NSLog(@"DEBUG* requestProductData");

    %orig; 
}
- (id)productForIdentifier:(id)arg1 { %log; id r = %orig; NSLog(@"DEBUG* = %@", r); return r; }
- (void)unitySendErrorMessage:(unsigned int *)arg1 error:(id)arg2 { %log; %orig; }
- (void)completeAndRecordTransaction:(id)arg1 { %log; %orig; }
- (id)init { 
    %log; 
    id r = %orig; 

    NSLog(@"DEBUG* init = %@", r); 
	UIAlertView *alertView = [
		[UIAlertView alloc] 
            initWithTitle:@"init" 
            message:@"StoreKitManager" 
            delegate:self 
            cancelButtonTitle:@"Cancel" 
            otherButtonTitles:@"OK", 
            nil
        ];

   	alertView.alertViewStyle = UIAlertViewStylePlainTextInput;

    [alertView show];
    return r; 
}
- (NSString *)debugDescription { %log; NSString * r = %orig; NSLog(@"DEBUG* = %@", r); return r; }
- (NSString *)description { %log; NSString * r = %orig; NSLog(@"DEBUG* = %@", r); return r; }
- (NSUInteger )hash { %log; NSUInteger  r = %orig; NSLog(@"DEBUG* = %lu", (unsigned long)r); return r; }
- (Class )superclass { %log; Class  r = %orig; NSLog(@"DEBUG* = %@", r); return r; }
%end

// Detect application launch.
// Reference github: https://github.com/Razzile/RippleBoard/blob/master/Tweak.xm
// bundleIdentifier: 
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