//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

// #import "NSObject.h"

// #import "SKPaymentTransactionObserver.h"
// #import "SKProductsRequestDelegate.h"
// #import "SKStoreProductViewControllerDelegate.h"
// #import "StoreKitReceiptRequestDelegate.h"

@class NSArray, NSMutableArray, NSString, SKPayment;
@class NSObject, SKStoreProductViewControllerDelegate;
@protocol SKProductsRequestDelegate, StoreKitReceiptRequestDelegate;

@interface StoreKitManager : NSObject <SKProductsRequestDelegate, SKPaymentTransactionObserver, StoreKitReceiptRequestDelegate, SKStoreProductViewControllerDelegate>
{
    _Bool supportsDownloads;
    _Bool sendTransactionUpdateEvents;
    _Bool loggingEnabled;
    NSArray *products;
    NSMutableArray *currentTransactions;
    NSString *applicationUserName;
    SKPayment *_deferredPayment;
}

+ (void)unitySendMessage:(id)arg1 param:(id)arg2;
+ (id)sharedManager;
@property(retain, nonatomic) SKPayment *deferredPayment; // @synthesize deferredPayment=_deferredPayment;
@property(copy, nonatomic) NSString *applicationUserName; // @synthesize applicationUserName;
@property _Bool loggingEnabled; // @synthesize loggingEnabled;
@property _Bool sendTransactionUpdateEvents; // @synthesize sendTransactionUpdateEvents;
@property _Bool supportsDownloads; // @synthesize supportsDownloads;
@property(retain) NSMutableArray *currentTransactions; // @synthesize currentTransactions;
@property(retain, nonatomic) NSArray *products; // @synthesize products;
- (void)productViewControllerDidFinish:(id)arg1;
- (void)storeKitReceiptRequest:(id)arg1 validatedWithStatusCode:(int)arg2;
- (void)storeKitReceiptRequest:(id)arg1 validatedWithResponse:(id)arg2;
- (void)storeKitReceiptRequest:(id)arg1 didFailWithError:(id)arg2;
- (void)paymentQueue:(id)arg1 updatedDownloads:(id)arg2;
- (void)paymentQueueRestoreCompletedTransactionsFinished:(id)arg1;
- (void)paymentQueue:(id)arg1 restoreCompletedTransactionsFailedWithError:(id)arg2;
- (void)paymentQueue:(id)arg1 removedTransactions:(id)arg2;
- (_Bool)paymentQueue:(id)arg1 shouldAddStorePayment:(id)arg2 forProduct:(id)arg3;
- (void)paymentQueue:(id)arg1 updatedTransactions:(id)arg2;
- (void)request:(id)arg1 didFailWithError:(id)arg2;
- (void)productsRequest:(id)arg1 didReceiveResponse:(id)arg2;
- (void)displayStoreWithProductId:(id)arg1 affiliateToken:(id)arg2;
- (void)cancelDownloads;
- (void)resumeDownloads;
- (void)pauseDownloads;
- (void)updateStorePromotionVisibility:(long long)arg1 forProductId:(id)arg2;
- (void)fetchStorePromotionVisibilityForProductId:(id)arg1;
- (id)getAllCurrentTransactions;
- (id)getAllSavedTransactions;
- (void)validateAutoRenewableReceipt:(id)arg1 withSecret:(id)arg2 isTestReceipt:(_Bool)arg3;
- (void)validateReceipt:(id)arg1 isTestReceipt:(_Bool)arg2;
- (void)finishPendingTransaction:(id)arg1;
- (void)finishPendingTransactions;
- (void)purchaseProduct:(id)arg1 quantity:(int)arg2;
- (_Bool)canMakePayments;
- (void)requestProductData:(id)arg1;
- (id)productForIdentifier:(id)arg1;
- (void)unitySendErrorMessage:(const char *)arg1 error:(id)arg2;
- (void)completeAndRecordTransaction:(id)arg1;
- (id)init;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

