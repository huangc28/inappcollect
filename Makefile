TARGET := iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = SpringBoard

# TODO API_HOST value should be feeded from external env file.

# Local machine inet IP
#API_HOST:=http://192.168.50.94

# Production IP
#API_HOST:=http://atuuapi.darkpanda.love

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = inappcollect

# Multiple tweaks
inappcollect_FILES = Tweak.xm $\
	$(wildcard  ./src/*.m) $\
	$(wildcard ./src/*.xm) $\
	$(wildcard ../SharedLibraries/*.m) $\
	LineageRCollect.xm $\
	LineageMLive.xm $\
	Snail.xm $\
	ProductInfoDelegate.m $\
	ClassUtil.m $\
	RequestCompletedHandler.m
inappcollect_CFLAGS = -fobjc-arc
inappcollect_CFLAGS += -DAPI_HOST=@\"$(API_HOST)\"

inappcollect_FRAMEWORKS = StoreKit UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

