################################################################################
#
# genie_assistant
#
################################################################################

GENIE_ASSISTANT_VERSION = bab92fea8b2563b611bf647f136cf6540a5bd35d
GENIE_ASSISTANT_SITE = $(call github,nwlab,genie_assistant,$(GENIE_ASSISTANT_VERSION))
GENIE_ASSISTANT_LICENSE = GPL-2.0

GENIE_ASSISTANT_DEPENDENCIES = python3 snowboy

define GENIE_ASSISTANT_BUILD_CMDS
endef

define GENIE_ASSISTANT_INSTALL_TARGET_CMDS
    mkdir -p $(TARGET_DIR)/root/assist
    cp -dpfr $(@D)/* $(TARGET_DIR)/root/assist/
    cd $(TARGET_DIR)/root/assist/speech/; ln -s ../../../usr/lib/$(SNOWBOY_PYTHON_DIR)/site-packages/snowboy ./snow_lib
    cd $(TARGET_DIR)/root/assist/speech/; ln -s ../../../usr/share/pocketsphinx/model/lm/ru/zero_ru.cd_cont_4000 ./ru_ru
endef

$(eval $(generic-package))
