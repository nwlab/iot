################################################################################
#
# libdotconf
#
################################################################################

LIBDOTCONF_VERSION = 651d87f20fa647139b8f969577d0391266d53288
LIBDOTCONF_SITE = $(call github,williamh,dotconf,$(LIBDOTCONF_VERSION))

LIBDOTCONF_LICENSE = GPL-2.0
LIBDOTCONF_LICENSE_FILES = COPYING
LIBDOTCONF_DEPENDENCIES = host-pkgconf
LIBDOTCONF_INSTALL_STAGING = YES
LIBDOTCONF_AUTORECONF = YES
LIBDOTCONF_MAKE = $(MAKE1)

# Autoreconf requires an existing m4 directory
define LIBDOTCONF_MKDIR_M4
	mkdir -p $(@D)/m4
endef
LIBDOTCONF_POST_PATCH_HOOKS += LIBDOTCONF_MKDIR_M4

LIBDOTCONF_INSTALL_STAGING_OPTS = DESTDIR=$(STAGING_DIR) install
LIBDOTCONF_INSTALL_TARGET_OPTS = DESTDIR=$(TARGET_DIR) install

#define LIBDOTCONF_CONFIGURE_CMDS
#	(cd $(@D) && \
#	$(TARGET_CONFIGURE_OPTS) \
#	$(TARGET_CONFIGURE_ARGS) \
#	./configure \
#   	--target=$(GNU_TARGET_NAME) \
#		--host=$(GNU_TARGET_NAME) \
#		--build=$(GNU_HOST_NAME) \
#		--prefix=/usr \
#		--exec-prefix=/usr \
#		--sysconfdir=/etc \
#		--program-prefix="" \
#    	--with-sysroot="$(STAGING_DIR)" \
#	)
#endef

$(eval $(autotools-package))
