#import "ArknightsCollect.h"
#import "Lineage2Collect.h"
#import "LineageRCollect.h"
#import "LineageMLive.h"

// %ctor gets called when executable is loaded into the memory
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
}
