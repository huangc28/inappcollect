//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//
@class NSDictionary, NSNumber, NSString;

@interface U8ProductInfo : NSObject
{
    NSString *_orderID;
    NSString *_productId;
    NSString *_productName;
    NSString *_productDesc;
    NSNumber *_price;
    long long _buyNum;
    NSString *_roleId;
    NSString *_roleName;
    NSString *_roleLevel;
    NSString *_vip;
    NSString *_serverId;
    NSString *_serverName;
    NSDictionary *_extension;
}

+ (id)productFromJsonString:(id)arg1;
@property(retain, nonatomic) NSDictionary *extension; // @synthesize extension=_extension;
@property(retain, nonatomic) NSString *serverName; // @synthesize serverName=_serverName;
@property(retain, nonatomic) NSString *serverId; // @synthesize serverId=_serverId;
@property(retain, nonatomic) NSString *vip; // @synthesize vip=_vip;
@property(retain, nonatomic) NSString *roleLevel; // @synthesize roleLevel=_roleLevel;
@property(retain, nonatomic) NSString *roleName; // @synthesize roleName=_roleName;
@property(retain, nonatomic) NSString *roleId; // @synthesize roleId=_roleId;
@property long long buyNum; // @synthesize buyNum=_buyNum;
@property(retain, nonatomic) NSNumber *price; // @synthesize price=_price;
@property(retain, nonatomic) NSString *productDesc; // @synthesize productDesc=_productDesc;
@property(retain, nonatomic) NSString *productName; // @synthesize productName=_productName;
@property(retain, nonatomic) NSString *productId; // @synthesize productId=_productId;
@property(retain, nonatomic) NSString *orderID; // @synthesize orderID=_orderID;
- (id)toJsonString;
- (id)toDict;
- (id)initWithDict:(id)arg1;

@end

