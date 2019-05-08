################################################################################
#
# analogclock
#
################################################################################

ANALOGCLOCK_VERSION = 0
ANALOGCLOCK_SITE = $(TOPDIR)/../package/analogclock
ANALOGCLOCK_SITE_METHOD = file
ANALOGCLOCK_SOURCE = analogclock.tar.gz
ANALOGCLOCK_LICENSE = GPL

ANALOGCLOCK_DEPENDENCIES = qt5base

define ANALOGCLOCK_CONFIGURE_CMDS
	cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/usr/bin/qmake
endef

define ANALOGCLOCK_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define ANALOGCLOCK_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/analogclock $(TARGET_DIR)/usr/bin 
endef

$(eval $(generic-package))
