TARGET := iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = inappcollect

# Multiple tweaks
inappcollect_FILES = Tweak.xm $\
	$(wildcard ./UncleTuuCollectorCore/*.m) $\
	$(wildcard ../SharedLibraries/*.m) $\
	$(wildcard  ./src/*.m) $\
	$(wildcard ./src/*.xm)
inappcollect_CFLAGS = -fobjc-arc
inappcollect_CFLAGS += -DAPI_HOST=@\"$(API_HOST)\"

inappcollect_FRAMEWORKS = StoreKit UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

