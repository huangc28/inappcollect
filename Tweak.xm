#import "src/Lineage2MCollect.h"
#import "src/ArknightsCollect.h"
#import "src/LineageMLive.h"
#import "src/LineageRCollect.h"
#import "src/Snail.h"

%ctor {
	NSLog(@"DEBUG* inapp collect started!");

	// 明日方舟
	InitArknightsGroup();

	// 天堂 2 M
	InitLineage2MGroup();

	// 天堂 W
	InitLineageRCollect();

	// 天堂 M
	InitLineageMLiveCollect();

	// 最強蝸牛
	InitSnail();
}
