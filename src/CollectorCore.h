#import "Foundation/Foundation.h"

@interface CollectorCore : NSObject {
	NSMutableDictionary<NSString*, NSNumber*> *_collectedProds;
}

@property(strong, nonatomic) NSMutableDictionary<NSString*, NSNumber*> *collectedProds; // @synthesize collectedProds=_collectedProds

+ (instancetype)sharedInstance;

- (void)collect:(NSString *)prodID
	bundleID:(NSString *)bundleID
	prodName:(NSString *)prodName
	prodDesc:(NSString *)prodDesc
	price   :(NSNumber *)price
	quantity:(long long)quantity;

- (void)markCollectedProdToDictionary:(NSString *)prodID;
- (void)unmarkCollectedProdToDictionary:(NSString *)prodID;
- (_Bool)hasProdCollected:(NSString *)prodID;

@end
