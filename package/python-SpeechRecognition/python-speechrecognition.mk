################################################################################
#
# python-speechrecognition
#
################################################################################

PYTHON_SPEECHRECOGNITION_VERSION = 3.8.1
PYTHON_SPEECHRECOGNITION_SOURCE = $(PYTHON_SPEECHRECOGNITION_VERSION).tar.gz
PYTHON_SPEECHRECOGNITION_SITE = https://github.com/Uberi/speech_recognition/archive
PYTHON_SPEECHRECOGNITION_SETUP_TYPE = distutils
PYTHON_SPEECHRECOGNITION_LICENSE = Python-2.0
PYTHON_SPEECHRECOGNITION_LICENSE_FILES = LICENSE
PYTHON_SPEECHRECOGNITION_DEPENDENCIES = python-PyAudio flac

ifeq ($(BR2_PACKAGE_PYTHON),y)
PYTHON_SPEECHRECOGNITION_PYTHON_DIR = python$(PYTHON_VERSION_MAJOR)
else ifeq ($(BR2_PACKAGE_PYTHON3),y)
PYTHON_SPEECHRECOGNITION_PYTHON_DIR = python$(PYTHON3_VERSION_MAJOR)
endif

define PYTHON_SPEECHRECOGNITION_REMOVE_FLAC
	rm -rf $(TARGET_DIR)/usr/lib/$(PYTHON_SPEECHRECOGNITION_PYTHON_DIR)/site-packages/speech_recognition/flac-*
endef

PYTHON_SPEECHRECOGNITION_POST_INSTALL_TARGET_HOOKS += PYTHON_SPEECHRECOGNITION_REMOVE_FLAC

$(eval $(python-package))