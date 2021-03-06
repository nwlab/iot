################################################################################
#
# speech-dispatcher
#
################################################################################

SPEECH_DISPATCHER_VERSION = a6660e9b074aa528678dd68f6903f774f3c8bb6b
SPEECH_DISPATCHER_SITE = $(call github,brailcom,speechd,$(SPEECH_DISPATCHER_VERSION))

SPEECH_DISPATCHER_LICENSE = MIT
SPEECH_DISPATCHER_LICENSE_FILES = COPYING
SPEECH_DISPATCHER_DEPENDENCIES = host-intltool host-pkgconf libtool libsndfile libdotconf

SPEECH_DISPATCHER_AUTORECONF = YES
SPEECH_DISPATCHER_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_PICOTTS),y)
SPEECH_DISPATCHER_DEPENDENCIES += picotts
endif

define SPEECH_DISPATCHER_TARBALL_VERSION
	echo "0.9.1" >>$(@D)/.tarball-version
endef

SPEECH_DISPATCHER_POST_PATCH_HOOKS += SPEECH_DISPATCHER_TARBALL_VERSION

define SPEECH_DISPATCHER_INSTALL_ESPEAK
	$(TARGET_MAKE_ENV) $(MAKE) -C $(ESPEAK_DIR)/src DESTDIR="$(STAGING_DIR)" install
	$(INSTALL) -D -m 0755 $(SPEECH_DISPATCHER_PKGDIR)S98speechd \
		$(TARGET_DIR)/etc/init.d/S98speechd
endef

ifeq ($(BR2_PACKAGE_ESPEAK),y)
SPEECH_DISPATCHER_DEPENDENCIES += espeak
SPEECH_DISPATCHER_PRE_CONFIGURE_HOOKS += SPEECH_DISPATCHER_INSTALL_ESPEAK
endif

ifeq ($(BR2_PACKAGE_ESPEAK_NG),y)
SPEECH_DISPATCHER_DEPENDENCIES += espeak-ng
endif

SPEECH_DISPATCHER_FIXUP_MODULE_LIST=

ifeq ($(BR2_PACKAGE_SPEECH_DISPATCHER_ESPEAK),)
SPEECH_DISPATCHER_FIXUP_MODULE_LIST += sd_espeak
endif

ifeq ($(BR2_PACKAGE_SPEECH_DISPATCHER_ESPEAK_NG),)
SPEECH_DISPATCHER_FIXUP_MODULE_LIST += sd_espeak_ng
endif

ifeq ($(BR2_PACKAGE_SPEECH_DISPATCHER_PICOTTS),)
SPEECH_DISPATCHER_FIXUP_MODULE_LIST += sd_pico
endif

ifeq ($(BR2_PACKAGE_SPEECH_DISPATCHER_FESTIVAL),)
SPEECH_DISPATCHER_FIXUP_MODULE_LIST += sd_festival
endif

ifeq ($(BR2_PACKAGE_SPEECH_DISPATCHER_CICERO),)
SPEECH_DISPATCHER_FIXUP_MODULE_LIST += sd_cicero
endif

define SPEECH_DISPATCHER_FIXUP_MODULES
	$(foreach tool,$(SPEECH_DISPATCHER_FIXUP_MODULE_LIST),\
		rm -f $(TARGET_DIR)/usr/lib/speech-dispatcher-modules/$(tool) \
	)
endef
SPEECH_DISPATCHER__POST_INSTALL_HOOKS += SPEECH_DISPATCHER_FIXUP_MODULES

$(eval $(autotools-package))
