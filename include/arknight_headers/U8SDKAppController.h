//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UnityAppController.h"

#import "U8SDKDelegate.h"

@class NSString;

@interface U8SDKAppController : UnityAppController <U8SDKDelegate>
{
}

+ (void)load;
- (void)applicationWillTerminate:(id)arg1;
- (void)applicationDidBecomeActive:(id)arg1;
- (void)applicationWillEnterForeground:(id)arg1;
- (void)applicationDidEnterBackground:(id)arg1;
- (void)applicationWillResignActive:(id)arg1;
- (unsigned long long)application:(id)arg1 supportedInterfaceOrientationsForWindow:(id)arg2;
- (_Bool)application:(id)arg1 openURL:(id)arg2 sourceApplication:(id)arg3 annotation:(id)arg4;
- (_Bool)application:(id)arg1 didFinishLaunchingWithOptions:(id)arg2;
- (void)OnEventCustom:(id)arg1;
- (void)OnSDKError:(id)arg1;
- (void)OnSwitchAccount:(id)arg1;
- (void)OnPayFailed:(id)arg1;
- (void)OnPayPaid:(id)arg1;
- (void)OnUserLogout:(id)arg1;
- (void)OnUserLoginFailed:(id)arg1;
- (void)OnUserLogin:(id)arg1;
- (void)OnPlatformInitFailed:(id)arg1;
- (void)OnPlatformInit:(id)arg1;
- (id)GetViewController;
- (id)GetView;
- (void)showAlertView:(id)arg1 withCallback:(CDUnknownBlockType)arg2;
- (void)SendCallback:(const char *)arg1 withParams:(id)arg2;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

