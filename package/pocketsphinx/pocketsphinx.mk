POCKETSPHINX_VERSION=0.6.1
POCKETSPHINX_SOURCE=pocketsphinx-$(POCKETSPHINX_VERSION).tar.gz
POCKETSPHINX_SITE=http://downloads.sourceforge.net/project/cmusphinx/pocketsphinx/$(POCKETSPHINX_VERSION)
POCKETSPHINX_AUTORECONF = YES
POCKETSPHINX_INSTALL_STAGING = YES
POCKETSPHINX_INSTALL_TARGET = YES
POCKETSPHINX_DEPENDENCIES = sphinxbase2
POCKETSPHINX_CONF_OPTS = --without-python
POCKETSPHINX_INSTALL_STAGING_OPTS = DESTDIR=$(STAGING_DIR) LDFLAGS="-L$(STAGING_DIR)/usr/lib -L$(STAGING_DIR)/lib" install

define POCKETSPHINX_POST_INSTALL_RUS_SUPPORT
  wget -c -t 20 -P $(@D) 'http://citylan.dl.sourceforge.net/project/cmusphinx/Acoustic%20and%20Language%20Models/Russian%20Audiobook%20Morphology%20Zero/zero_ru_cont_8k.tar.gz'
  tar xzvf $(@D)/zero_ru_cont_8k.tar.gz -C $(@D)
  mkdir -p $(TARGET_DIR)/usr/share/pocketsphinx/model/hmm/ru/zero_ru_cd_cont_2000
  mkdir -p $(TARGET_DIR)/usr/share/pocketsphinx/model/lm/ru
  $(INSTALL) -D -m 0755 $(@D)/zero_ru_cont_8k/zero_ru.* $(TARGET_DIR)/usr/share/pocketsphinx/model/lm/ru
  $(INSTALL) -D -m 0755 $(@D)/zero_ru_cont_8k/zero_ru_cd_cont_2000/* $(TARGET_DIR)/usr/share/pocketsphinx/model/hmm/ru/zero_ru_cd_cont_2000
endef

ifeq ($(BR2_PACKAGE_POCKETSPHINX_RUS), y)
POCKETSPHINX_POST_INSTALL_TARGET_HOOKS+= POCKETSPHINX_POST_INSTALL_RUS_SUPPORT
endif

$(eval $(autotools-package))
