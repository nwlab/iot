#POCKETSPHINX_VERSION=0.6.1
POCKETSPHINX_VERSION=5prealpha
POCKETSPHINX_SOURCE=pocketsphinx-$(POCKETSPHINX_VERSION).tar.gz
POCKETSPHINX_SITE=http://downloads.sourceforge.net/project/cmusphinx/pocketsphinx/$(POCKETSPHINX_VERSION)
                  https://sourceforge.net/projects/cmusphinx/files/pocketsphinx/5prealpha/pocketsphinx-5
POCKETSPHINX_AUTORECONF = YES
POCKETSPHINX_INSTALL_STAGING = YES
POCKETSPHINX_INSTALL_TARGET = YES
POCKETSPHINX_DEPENDENCIES = sphinxbase
POCKETSPHINX_CONF_OPTS = --without-python
POCKETSPHINX_INSTALL_STAGING_OPTS = DESTDIR=$(STAGING_DIR) LDFLAGS="-L$(STAGING_DIR)/usr/lib -L$(STAGING_DIR)/lib" install

define POCKETSPHINX_POST_INSTALL_RUS_SUPPORT

#  wget -c -t 20 -P $(@D) -O zero_ru_cont_8k_v3.tar.gz 'https://downloads.sourceforge.net/project/cmusphinx/Acoustic%20and%20Language%20Models/Russian/zero_ru_cont_8k_v3.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fcmusphinx%2Ffiles%2FAcoustic%2520and%2520Language%2520Models%2FRussian%2Fzero_ru_cont_8k_v3.tar.gz%2Fdownload%3Fuse_mirror%3Dnetcologne&ts=1576682400&use_mirror=netcologne'
#  wget -c -t 20 -P $(@D) -O zero_ru_cont_8k_v3.tar.gz 'https://downloads.sourceforge.net/project/cmusphinx/Acoustic%20and%20Language%20Models/Russian/zero_ru_cont_8k_v3.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fcmusphinx%2Ffiles%2FAcoustic%2520and%2520Language%2520Models%2FRussian%2Fzero_ru_cont_8k_v3.tar.gz%2Fdownload%3Fuse_mirror%3Dcfhcable&ts=1576709654&use_mirror=cfhcable'
#  tar xzvf $(@D)/zero_ru_cont_8k_v3.tar.gz -C $(@D)
  tar xzvf $(TOPDIR)/../package/pocketsphinx/zero_ru_cont_8k_v3.tar.gz -C $(@D)
  mkdir -p $(TARGET_DIR)/usr/share/pocketsphinx/model/hmm/ru/zero_ru_cd_cont_2000
  mkdir -p $(TARGET_DIR)/usr/share/pocketsphinx/model/lm/ru
#  $(INSTALL) -D -m 0755 $(@D)/zero_ru_cont_8k_v3/zero_ru.* $(TARGET_DIR)/usr/share/pocketsphinx/model/lm/ru
#  $(INSTALL) -D -m 0755 $(@D)/zero_ru_cont_8k_v3/zero_ru_cd_cont_2000/*  $(TARGET_DIR)/usr/share/pocketsphinx/model/hmm/ru/zero_ru_cd_cont_2000
  cp -r $(@D)/zero_ru_cont_8k_v3/zero_ru.* $(TARGET_DIR)/usr/share/pocketsphinx/model/lm/ru
#  cp -r $(@D)/zero_ru_cont_8k_v3/zero_ru_cd_cont_2000/*  $(TARGET_DIR)/usr/share/pocketsphinx/model/hmm/ru/zero_ru_cd_cont_2000
endef

ifeq ($(BR2_PACKAGE_POCKETSPHINX_RUS), y)
POCKETSPHINX_POST_INSTALL_TARGET_HOOKS+= POCKETSPHINX_POST_INSTALL_RUS_SUPPORT
endif

$(eval $(autotools-package))
