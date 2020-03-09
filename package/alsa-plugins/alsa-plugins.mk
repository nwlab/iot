################################################################################
#
# alsa-plugins
#
################################################################################

ALSA_PLUGINS_VERSION = 2d65f367d004fce1cefc88bb0d57d69d18d69208
ALSA_PLUGINS_SITE = $(call github,alsa-project,alsa-plugins,$(ALSA_PLUGINS_VERSION))
ALSA_PLUGINS_LICENSE = GPL-2.0+
ALSA_PLUGINS_LICENSE_FILES = COPYING.GPL
ALSA_PLUGINS_DEPENDENCIES = host-pkgconf alsa-lib \
	$(if $(BR2_PACKAGE_LIBSAMPLERATE),libsamplerate)

# git, no configure
ALSA_PLUGINS_AUTORECONF = YES

$(eval $(autotools-package))
