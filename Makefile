TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = testproj3

# Multiple tweaks
testproj3_FILES = Tweak.xm HttpUtil.m
testproj3_CFLAGS = -fobjc-arc
testproj3_FRAMEWORKS = StoreKit UIKit 

include $(THEOS_MAKE_PATH)/tweak.mk
	