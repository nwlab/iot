################################################################################
#
# atlas
#
################################################################################

# pkg info
NBD_VERSION = 3.20
NBD_SOURCE = nbd-$(NBD_VERSION).tar.xz
NBD_SITE = http://downloads.sourceforge.net/project/nbd/nbd/$(NBD_VERSION)

ATLAS_VERSION = 3.10.3
ATLAS_SOURCE = atlas$(ATLAS_VERSION).tar.bz2
ATLAS_SITE = http://downloads.sourceforge.net/project/math-atlas/Stable/$(ATLAS_VERSION)
ATLAS_LICENSE = Apache-2.0


ATLAS_CONF_OPTS = \
	--cc="$(TARGET_CC)" \
	--cflags="$(ATLAS_CFLAGS)" \
	--prefix="/usr" \
    --nof77 

define ATLAS_CONFIGURE_CMDS
	(mkdir -p  $(@D)/build; cd $(@D)/build; ../configure $(ATLAS_CONF_OPTS) )
endef

# build
$(eval $(autotools-package))
