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

$(eval $(python-package))
