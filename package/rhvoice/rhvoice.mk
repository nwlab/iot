################################################################################
#
# rhvoice
#
################################################################################

RHVOICE_VERSION = 9ee7d90e0319b3dc8f1c869746b0ca27a1f1aa28
RHVOICE_SITE = $(call github,Olga-Yakovleva,RHVoice,$(RHVOICE_VERSION))
RHVOICE_LICENSE = LGPL v2.1
RHVOICE_LICENSE_FILES = LICENSE
RHVOICE_DEPENDENCIES = host-python3 host-scons host-pkgconf host-python-lxml

ifeq ($(BR2_PACKAGE_PORTAUDIO),y)
RHVOICE_DEPENDENCIES += portaudio
#RHVOICE_CONF_OPTS += -DALSOFT_REQUIRE_PORTAUDIO=ON
else
#RHVOICE_CONF_OPTS += -DALSOFT_REQUIRE_PORTAUDIO=OFF
endif

ifeq ($(BR2_PACKAGE_PULSEAUDIO),y)
RHVOICE_DEPENDENCIES += pulseaudio
else
#RHVOICE_CONF_OPTS += 
endif

ifeq ($(BR2_PACKAGE_LIBAO),y)
RHVOICE_DEPENDENCIES += libao
else
#RHVOICE_CONF_OPTS += 
endif

define RHVOICE_POST_INSTALL_TARGET_FIXUP
    ln -sf ../../bin/sd_rhvoice $(TARGET_DIR)/usr/lib/speech-dispatcher-modules
	$(INSTALL) -D -m 0644 $(RHVOICE_PKGDIR)rhvoice.conf \
		$(TARGET_DIR)/etc/speech-dispatcher/modules/rhvoice.conf
endef

ifeq ($(BR2_PACKAGE_SPEECH_DISPATCHER),y)
RHVOICE_DEPENDENCIES += speech-dispatcher
RHVOICE_POST_INSTALL_TARGET_HOOKS += RHVOICE_POST_INSTALL_TARGET_FIXUP
else
#RHVOICE_CONF_OPTS += 
endif

define RHVOICE_FIX_PKGCONFIG
	$(SED) 's^\"pkg-config^\"$(PKG_CONFIG_HOST_BINARY)^' \
		$(RHVOICE_DIR)/SConstruct
	$(SED) 's^\!pkg-config^\!$(PKG_CONFIG_HOST_BINARY)^' \
		$(RHVOICE_DIR)/src/audio/SConscript
endef

define RHVOICE_FIX_GCC
	$(SED) 's^TARGET_CC^$(TARGET_CC)^' \
		$(RHVOICE_DIR)/SConstruct
	$(SED) 's^TARGET_CXX^$(TARGET_CXX)^' \
		$(RHVOICE_DIR)/SConstruct
	$(SED) 's^TARGET_CPP^$(TARGET_CPP)^' \
		$(RHVOICE_DIR)/SConstruct
endef

RHVOICE_SCONS_ENV = \
        CPPPATH="$(STAGING_DIR)"/usr/include \
        LIBPATH="$(STAGING_DIR)"/usr/lib \
	-j"$(PARALLEL_JOBS)"

RHVOICE_SCONS_OPTS = 

RHVOICE_SCONS_TARGETS = languages='english,russian' \
                        audio_libs='libao,portaudio' \
                        spd_version='0.9.1'

define RHVOICE_BUILD_CMDS
	$(RHVOICE_FIX_PKGCONFIG)
	$(RHVOICE_FIX_GCC)
	(cd $(@D); \
		$(HOST_DIR)/bin/python $(SCONS) \
		$(RHVOICE_SCONS_ENV) \
		$(RHVOICE_SCONS_OPTS) \
		$(RHVOICE_SCONS_TARGETS) \
		sysconfdir=/etc \
		prefix='/usr')
endef

define RHVOICE_INSTALL_TARGET_CMDS
	(cd $(@D); \
		$(HOST_DIR)/bin/python $(SCONS) \
		$(RHVOICE_SCONS_ENV) \
		$(RHVOICE_SCONS_OPTS) \
		sysconfdir=/etc \
		prefix=/usr \
        DESTDIR=$(TARGET_DIR) \
		install)
endef


$(eval $(generic-package))
