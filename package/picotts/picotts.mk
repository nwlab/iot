################################################################################
#
# picotts
#
################################################################################

# pkg info
PICOTTS_VERSION = 2f86050dc5da9ab68fc61510b594d8e6975c4d2d
PICOTTS_SITE = $(call github,naggety,picotts,$(PICOTTS_VERSION))
PICOTTS_LICENSE = Apache-2.0

# dependencies
PICOTTS_DEPENDENCIES = popt

# extract
define PICOTTS_EXTRACT_CMDS
   tar xf $(PICOTTS_DL_DIR)/picotts-$(PICOTTS_VERSION).tar.gz -C $(@D) \
   picotts-$(PICOTTS_VERSION)/pico --strip-components=2
endef

# generate build files (autotools)
PICOTTS_PRE_CONFIGURE_HOOKS += PICOTTS_EXEC_AUTOGEN
define PICOTTS_EXEC_AUTOGEN
   cd $(@D) && ./autogen.sh
endef

# install additional files
PICOTTS_POST_INSTALL_TARGET_HOOKS += PICOTTS_INSTALL_ADDITIONAL_FILES
define PICOTTS_INSTALL_ADDITIONAL_FILES
   $(INSTALL) -D -m 0755 $(TOPDIR)/$(PICOTTS_PKGDIR)/picotts $(TARGET_DIR)/usr/bin/picotts
   $(INSTALL) -D -m 0755 $(TOPDIR)/$(PICOTTS_PKGDIR)/picotts-lc $(TARGET_DIR)/usr/bin/picotts-lc
endef

# build
$(eval $(autotools-package))
