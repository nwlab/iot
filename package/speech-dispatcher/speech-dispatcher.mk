################################################################################
#
# speech-dispatcher
#
################################################################################

SPEECH_DISPATCHER_VERSION = a6660e9b074aa528678dd68f6903f774f3c8bb6b
SPEECH_DISPATCHER_SITE = $(call github,brailcom,speechd,$(SPEECH_DISPATCHER_VERSION))

SPEECH_DISPATCHER_LICENSE = MIT
SPEECH_DISPATCHER_LICENSE_FILES = COPYING
SPEECH_DISPATCHER_DEPENDENCIES = libsndfile libdotconf

SPEECH_DISPATCHER_AUTORECONF = YES

ifeq ($(BR2_PACKAGE_PICOTTS),y)
SPEECH_DISPATCHER_DEPENDENCIES += picotts
endif

define SPEECH_DISPATCHER_INSTALL_ESPEAK
	$(TARGET_MAKE_ENV) $(MAKE) -C $(ESPEAK_DIR)/src DESTDIR="$(STAGING_DIR)" install
endef

ifeq ($(BR2_PACKAGE_ESPEAK),y)
SPEECH_DISPATCHER_DEPENDENCIES += espeak
SPEECH_DISPATCHER_PRE_CONFIGURE_HOOKS += SPEECH_DISPATCHER_INSTALL_ESPEAK
endif

ifeq ($(BR2_PACKAGE_ESPEAK_NG),y)
SPEECH_DISPATCHER_DEPENDENCIES += espeak-ng
endif

$(eval $(autotools-package))
