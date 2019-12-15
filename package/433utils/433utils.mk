################################################################################
#
# 433Utils
#
################################################################################

433UTILS_VERSION = 31c0ea4e158287595a6f6116b6151e72691e1839
##433UTILS_SITE = $(call github,ninjablocks,433Utils,$(433UTILS_VERSION))
433UTILS_SITE = https://github.com/ninjablocks/433Utils
433UTILS_SITE_METHOD = git

433UTILS_LICENSE = MIT
433UTILS_LICENSE_FILES = COPYING
433UTILS_DEPENDENCIES = wiringpi 
433UTILS_GIT_SUBMODULES = YES


433UTILS_CONF_ENV += CXXFLAGS="$(TARGET_CXXFLAGS) -DRPI"

define 433UTILS_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/RPi_utils $(TARGET_CONFIGURE_OPTS) CXXFLAGS="$(TARGET_CXXFLAGS) -DRPI"
endef

define 433UTILS_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/RPi_utils/RFSniffer $(TARGET_DIR)/usr/bin/RFSniffer
	$(INSTALL) -m 0755 -D $(@D)/RPi_utils/send $(TARGET_DIR)/usr/bin/send
	$(INSTALL) -m 0755 -D $(@D)/RPi_utils/codesend $(TARGET_DIR)/usr/bin/codesend
endef

$(eval $(generic-package))
