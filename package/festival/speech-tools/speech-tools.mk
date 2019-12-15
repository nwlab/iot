#############################################################
#
# speech-tools
#
#############################################################

SPEECH_TOOLS_VERSION = 1.2.96~beta
SPEECH_TOOLS_SOURCE = speech-tools_$(SPEECH_TOOLS_VERSION).orig.tar.gz
SPEECH_TOOLS_PATCH = speech-tools_$(SPEECH_TOOLS_VERSION)-6.diff.gz
SPEECH_TOOLS_SITE = $(BR2_DEBIAN_MIRROR)/debian/pool/main/s/speech-tools/
SPEECH_TOOLS_AUTORECONF = NO
SPEECH_TOOLS_INSTALL_STAGING = NO
SPEECH_TOOLS_INSTALL_TARGET = YES
SPEECH_TOOLS_INSTALL_TARGET_OPTS = DESTDIR=$(TARGET_DIR) STRIP=$(TARGET_STRIP) install

SPEECH_TOOLS_CONF_OPTS =
SPEECH_TOOLS_MAKE_OPTS = CC="$(TARGET_CC)" CXX="$(TARGET_CXX)"

define SPEECH_TOOLS_DEBIAN_PATCH_APPLY
        for p in $$(cat $(@D)/debian/patches/series) ; do \
                toolchain/patch-kernel.sh $(@D) $(@D)/debian/patches $$p; \
        done
endef

SPEECH_TOOLS_POST_PATCH_HOOKS += SPEECH_TOOLS_DEBIAN_PATCH_APPLY

SPEECH_TOOLS_DEPENDENCIES = ncurses

$(eval $(autotools-package))
#$(eval $(call AUTOTARGETS,package/multimedia/festival,speech-tools))