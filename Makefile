TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = inappcollect

# Multiple tweaks
inappcollect_FILES = Tweak.xm $\
	GameData.m $\
		Alert.m  $\
		ClassUtil.m $\
	../SharedLibraries/HttpUtil.m
inappcollect_CFLAGS = -fobjc-arc
inappcollect_FRAMEWORKS = StoreKit UIKit


include $(THEOS_MAKE_PATH)/tweak.mk

