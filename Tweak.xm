#import "StoreKit/StoreKit.h"
#import "FrontBoard/FBProcess.h"

#import "Arknights/StoreKitManager.h"
#import "Arknights/U8ProductInfo.h"

#import "ArknightsCollect.h"
#import "Lineage2Collect.h"
#import "LineageRCollect.h"
#import "LineageMLive.h"
#import "KgtwCollect.h"

%group Hooks

// Detect application launch.
// Reference github: https://github.com/Razzile/RippleBoard/blob/master/Tweak.xm
// bundleIdentifier:
//   明日方舟: tw.txwy.ios.arknights
//   天堂2m  :
//     天堂w :
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

	// 明日方舟
	InitArknightsGroup();

	// 天堂 2 M
	InitLineage2Group();

	// 天堂 W
	InitLineageRCollect();

	// 天堂 M
	InitLineageMLiveCollect();

	// 傳說對決
	InitKgtwCollect();
}
