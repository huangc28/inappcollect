//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

@class SKPaymentTransaction;

@protocol SDKPassportDelegate
- (void)txwyDidPassport;

@optional
- (void)txwyPassportUpdated;
- (void)txwyPayCancelled;
- (void)txwyDidPay:(SKPaymentTransaction *)arg1;
@end

