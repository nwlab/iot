################################################################################
#
# dashboard
#
# dashboard -platform linuxfb:fb="/dev/fb1"
################################################################################

DASHBOARD_VERSION = 0
DASHBOARD_SITE = $(TOPDIR)/../package/dashboard
DASHBOARD_SITE_METHOD = file
DASHBOARD_SOURCE = dashboard.tar.gz
DASHBOARD_LICENSE = GPL

DASHBOARD_DEPENDENCIES = qt5base

define DASHBOARD_CONFIGURE_CMDS
	cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/usr/bin/qmake
endef

define DASHBOARD_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define DASHBOARD_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/dashboard $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
