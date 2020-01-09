################################################################################
#
# snowboy
#
################################################################################

# pkg info
SNOWBOY_VERSION = ba972b07f6b592d5bd2312b571685b85b6528a1e
SNOWBOY_SITE = $(call github,Kitt-AI,snowboy,$(SNOWBOY_VERSION))
SNOWBOY_LICENSE = Apache-2.0

# dependencies
SNOWBOY_DEPENDENCIES = host-python3 python3 host-swig

ifeq ($(BR2_PACKAGE_PYTHON3),y)
SNOWBOY_PYTHON_DIR = python$(PYTHON3_VERSION_MAJOR)
SNOWBOY_PYTHON = \
	PYTHON="$(HOST_DIR)/bin/python3" \
	PYTHON_CONFIG="$(STAGING_DIR)/usr/bin/python3-config" \
	PYTHON_INCLUDE="`$(STAGING_DIR)/usr/bin/python3-config --cflags`" \
	PYTHON_LIBS="`$(STAGING_DIR)/usr/bin/python3-config --ldflags`" \
    ATLAS_LIBS="-Wl,--whole-archive -L$(TOPDIR)/../package/snowboy/atlas/lib \
                -latlas \
                -lcblas \
                -lf77blas \
                -llapack \
                -lgfortran \
                -Wl,--no-whole-archive"
endif


define SNOWBOY_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(SNOWBOY_PYTHON) SOURCE_DIR=$(@D) $(MAKE) -C $(@D)/swig/Python3 $(TARGET_CONFIGURE_OPTS) CC="$(TARGET_CC)" CXX="$(TARGET_CXX)"
endef

define SNOWBOY_INSTALL_TARGET_CMDS
    mkdir -p $(TARGET_DIR)/usr/lib/$(SNOWBOY_PYTHON_DIR)/site-packages/snowboy
	touch $(TARGET_DIR)/usr/lib/$(SNOWBOY_PYTHON_DIR)/site-packages/snowboy/__init__.py
    cp -aL $(@D)/examples/Python3/* $(TARGET_DIR)/usr/lib/$(SNOWBOY_PYTHON_DIR)/site-packages/snowboy/
endef

# build
$(eval $(generic-package))
