################################################################################
#
# espeak-ng
#
################################################################################

ESPEAK_NG_VERSION = 7290b6f3cc9f5f437a948e4bd58d0554725c6093
ESPEAK_NG_SITE = $(call github,espeak-ng,espeak-ng,$(ESPEAK_NG_VERSION))

ESPEAK_NG_LICENSE = GPL-3.0+
ESPEAK_NG_LICENSE_FILES = COPYING

ESPEAK_NG_DEPENDENCIES = portaudio
ESPEAK_NG_INSTALL_STAGING = YES
ESPEAK_NG_MAKE = $(MAKE1)

ESPEAK_NG_CONF_OPTS = \
	--with-extdict-ru \

define ESPEAK_NG_CREATE_MISSING_FILES
	touch $(@D)/NEWS $(@D)/AUTHORS $(@D)/README
endef
#ESPEAK_NG_POST_EXTRACT_HOOKS += ESPEAK_NG_CREATE_MISSING_FILES

define ESPEAK_NG_RUN_AUTOGEN
	cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
endef
ESPEAK_NG_PRE_CONFIGURE_HOOKS += ESPEAK_NG_RUN_AUTOGEN

define ESPEAK_NG_BUILD_VOICE_DATA
	(cd $(@D) && rm -rf config.cache && \
	$(HOST_CONFIGURE_OPTS) \
    ACLOCAL="$(ACLOCAL)" AUTOCONF="$(AUTOCONF)" AUTOHEADER="$(AUTOHEADER)" AUTOMAKE="$(AUTOMAKE)" \
	./configure \
		--prefix=/usr \
		--target=$(GNU_HOST_NAME) \
		--host=$(GNU_HOST_NAME) \
		--build=$(GNU_HOST_NAME) \
		$(ESPEAK_NG_CONF_OPTS) \
	)
    $(HOST_MAKE_ENV) $(MAKE1) -C $(@D)
endef

#		$(SHARED_STATIC_LIBS_OPTS) \
#		--enable-static \

# When passing the standard buildroot configure arguments, the configure script
# breaks on --target and --host options. Thus we need to define a configure cmd
# ourselves.
define ESPEAK_NG_CONFIGURE_TARGET
	(cd $(@D) && rm -rf config.cache && \
	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_CONFIGURE_ARGS) \
	./configure \
		--prefix=/usr \
		--target=$(GNU_TARGET_NAME) \
		--host=$(GNU_TARGET_NAME) \
		--build=$(GNU_HOST_NAME) \
		$(SHARED_STATIC_LIBS_OPTS) \
		--enable-static \
		$(ESPEAK_NG_CONF_OPTS) \
	)
endef

define ESPEAK_NG_CONFIGURE_CMDS
	$(call ESPEAK_NG_BUILD_VOICE_DATA)
endef
#	$(call ESPEAK_NG_CONFIGURE_TARGET)

define ESPEAK_NG_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(MAKE1) -C $(@D) -B src/espeak-ng
    $(TARGET_MAKE_ENV) $(MAKE1) -C $(@D) -B src/speak-ng
endef

$(eval $(autotools-package))
