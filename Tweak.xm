#import "src/Lineage2MCollect.h"
#import "src/ArknightsCollect.h"
#import "src/LineageMLive.h"
#import "src/LineageRCollect.h"
#import "src/Snail.h"
#import "src/Mbmtw.h"
#import "src/HarryPotterCollect.h"
#import "src/CallmeBigBossCollect.h"
#import "src/MapleStory.h"
#import "src/CrownCollect.h"
// #import "src/TwysiosCollect.h"
#import "src/TdjCollect.h"
#import "src/MighttcCollect.h"

%ctor {
	NSLog(@"DEBUG* inapp collect started");

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

	// 天涯明月刀
	InitMbmtwGroup();

	// 哈利波特
	InitHarryPotterGroup();

	// 叫我大掌櫃
	InitCallmeBigBossCollect();

	// 楓之谷 R
	InitMaplestoryGroup();

	// 放置英雄
	InitCrownCollect();

	// 伊蘇 6
	// InitTwysiosCollect();

	// 天地劫
	InitTdjCollect();

	// 三國志 霸道
	InitMighttcCollect();
}
