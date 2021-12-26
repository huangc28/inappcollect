TARGET := iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = SpringBoard

# Default to be home IP.
API_HOST:=http://192.168.50.94

include $(THEOS)/makefiles/common.mk

include $(shell pwd)/.env

TWEAK_NAME = inappcollect

# Multiple tweaks
inappcollect_FILES = Tweak.xm $\
	ArknightsCollect.xm $\
	Lineage2Collect.xm $\
	LineageRCollect.xm $\
	KgtwCollect.xm $\
	LineageMLive.xm $\
	ProductInfoDelegate.m $\
	ClassUtil.m $\
	RequestCompletedHandler.m $\
	../SharedLibraries/HttpUtil.m $\
	../SharedLibraries/Alert.m
inappcollect_CFLAGS = -fobjc-arc
inappcollect_EXTRA_FRAMEWORKS = UnityFramework
inappcollect_FRAMEWORKS = StoreKit UIKit


include $(THEOS_MAKE_PATH)/tweak.mk

