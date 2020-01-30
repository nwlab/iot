################################################################################
#
# 
#
################################################################################

WM8960_VERSION = 873580cfd5b6844107199be1c54bda3a80a05e52
WM8960_SITE = $(call github,respeaker,seeed-voicecard,$(WM8960_VERSION))
WM8960_LICENSE = GPL-2.0, proprietary (*.bin firmware blobs)

WM8960_MODULE_MAKE_OPTS = \
	CONFIG_WM8960=m \
	KVER=$(LINUX_VERSION_PROBED) \
	KSRC=$(LINUX_DIR)

define WM8960_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/seeed-voicecard $(TARGET_DIR)/usr/bin/seeed-voicecard
	$(INSTALL) -D -m 0755 $(TOPDIR)/../package/wm8960/S97seeed-voicecard $(TARGET_DIR)/etc/init.d/S97seeed-voicecard
endef

define WM8960_INSTALL_DTB_OVERLAYS
	for ovldtb in  $(@D)/*.dtbo; do \
		$(INSTALL) -D -m 0644 $${ovldtb} $(BINARIES_DIR)/rpi-firmware/overlays/$${ovldtb##*/} || exit 1; \
	done
endef
WM8960_POST_INSTALL_TARGET_HOOKS += WM8960_INSTALL_DTB_OVERLAYS

$(eval $(kernel-module))
$(eval $(generic-package))
