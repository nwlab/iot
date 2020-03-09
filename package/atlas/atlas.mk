################################################################################
#
# atlas
#
################################################################################
# http://www.vesperix.com/arm/atlas-arm/faq/index.html
################################################################################
#
# MACHTYPE (55 = 'ARMa7')
# OSTYPE (1 = 'Linux')
#
ATLAS_VERSION = 3.10.3
ATLAS_SOURCE = atlas$(ATLAS_VERSION).tar.bz2
ATLAS_SITE = http://downloads.sourceforge.net/project/math-atlas/Stable/$(ATLAS_VERSION)
ATLAS_LICENSE = Apache-2.0

ATLAS_MAKE = $(MAKE1)
#ATLAS_INSTALL_TARGET = NO

# If you have a distribution using the hard floating-point ABI (like Ubuntu 12.04 or later), you can buld ATLAS 3.10.0 using
# ../configure -D c -DATL_ARM_HARDFP=1 -Si archdef 0 -Fa alg -mfloat-abi=hard
# for the soft floating-point ABI
# ../configure -D c -DATL_NONIEEE=1 -Si archdef 0
#if your distribution has a hard floating-point ABI. 
# ../configure -D c -DATL_NONIEEE=1 -D c -DATL_ARM_HARDFP=1 -Si archdef 0 -Fa alg -mfloat-abi=hard
ATLAS_CONF_OPTS = \
	--cc="$(TARGET_CC)" \
	--prefix="/usr/atlas" \
    -A 55 -O 1 \
    -D c -DATL_ARM_HARDFP=1 -Si archdef 0 \
    -C alg "$(TARGET_CC)" \
    -C if "$(TARGET_FC)" \
    -F alg "-O2" \

#    -Fa alg "-O2"
#    -C xc "$(HOSTCC)" \

# When Fortran is not available, only build the C version of BLAS
ifneq ($(BR2_TOOLCHAIN_HAS_FORTRAN),y)
ATLAS_CONF_OPTS += --nof77
endif
# Remote system to run tests
ifeq ($BR2_PACKAGE_ATLAS_PREBUILD),y)
ATLAS_CONF_OPTS += -T "root@$(BR2_PACKAGE_ATLAS_REMOTE_IP)"
endif

define ATLAS_APPLY_PATCHES
	$(SED) "s%XXX.XXX.XXX.XXX%$(BR2_PACKAGE_ATLAS_REMOTE_IP)%" \
		$(@D)/CONFIG/src/ATLrun.sh
	$(SED) "s%XXX.XXX.XXX.XXX%$(BR2_PACKAGE_ATLAS_REMOTE_IP)%" \
		$(@D)/CONFIG/src/Makefile
endef

ifeq ($BR2_PACKAGE_ATLAS_PREBUILD),y)
ATLAS_LIBS = $(TOPDIR)/../package/atlas/lib
else
ATLAS_POST_PATCH_HOOKS += ATLAS_APPLY_PATCHES
ATLAS_LIBS = $(STAGING_DIR)/usr/share/atlas/libs

################
# First, check in /sys/devices/system/cpu to see how many cores you have (you'll see directories named cpu0, cpu1, etc.). 
# Then run the following commands for each of the cores (we're showing cpu0 here, but you need to do this for all of them):
#    cd /sys/devices/system/cpu/cpu0/cpufreq
#    sudo sh -c "echo performance > scaling_governor" 
################
define ATLAS_APPLY_SCALING_GOVERNOR
	ssh "root@$(BR2_PACKAGE_ATLAS_REMOTE_IP)" "echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor;"
endef

endif

define ATLAS_CONFIGURE_CMDS
	$(ATLAS_APPLY_SCALING_GOVERNOR)
	(mkdir -p  $(@D)/build; cd $(@D)/build; STAGING_DIR="$(HOST_DIR)" HOSTCC="$(HOSTCC)" ../configure $(ATLAS_CONF_OPTS) )
	$(SED) "s,XCC\s\=.*,XCC = $(HOSTCC)," $(@D)/build/Make.inc
endef

define ATLAS_BUILD_CMDS
	(cd $(@D)/build; HOSTCC="$(HOSTCC)" $(ATLAS_MAKE) )
endef

define ATLAS_INSTALL_TARGET_CMDS
endef

define ATLAS_INSTALL_STAGING_CMDS
		mkdir -p $(ATLAS_LIBS); \
		cp -dpfr $(@D)/build/lib/*.a $(ATLAS_LIBS)/
endef

# build
$(eval $(autotools-package))
