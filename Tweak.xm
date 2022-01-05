#import "ArknightsCollect.h"
#import "Lineage2Collect.h"
#import "LineageRCollect.h"
#import "LineageMLive.h"
#import "Snail.h"

%ctor {
	NSLog(@"DEBUG* inapp collect started!");

	// 明日方舟
	InitArknightsGroup();

	// 天堂 2 M
	InitLineage2Group();

	// 天堂 W
	InitLineageRCollect();

	// 天堂 M
	InitLineageMLiveCollect();

	// 最強蝸牛
	InitSnail();
}
