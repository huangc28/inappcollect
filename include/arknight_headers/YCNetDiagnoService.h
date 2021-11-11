//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "YCNetConnectDelegate.h"
#import "YCNetPingDelegate.h"
#import "YCNetTraceRouteDelegate.h"

@class NSMutableString, NSString;

@interface YCNetDiagnoService : NSObject <YCNetPingDelegate, YCNetTraceRouteDelegate, YCNetConnectDelegate>
{
    int _port;
    NSMutableString *_reportInfoJson;
    CDUnknownBlockType _callback;
    NSString *_domain;
}

@property(retain, nonatomic) NSString *domain; // @synthesize domain=_domain;
- (void).cxx_destruct;
- (void)recordToReport:(id)arg1;
- (void)netTcpDidEnd:(id)arg1;
- (void)appendRouteLog:(id)arg1;
- (void)netPingDidEnd:(id)arg1;
- (void)recordLocalNetEnvironment;
- (void)startNetDiagnosis;
- (id)initWithdomain:(id)arg1 port:(int)arg2 Callback:(CDUnknownBlockType)arg3;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

