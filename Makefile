TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = testproj3

testproj3_FILES = Tweak.x
testproj3_CFLAGS = -fobjc-arc
testproj3_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
