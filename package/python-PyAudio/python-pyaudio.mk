################################################################################
#
# python-PyAudio
#
################################################################################

PYTHON_PYAUDIO_VERSION = 0.2.11
PYTHON_PYAUDIO_SOURCE = PyAudio-$(PYTHON_PYAUDIO_VERSION).tar.gz
PYTHON_PYAUDIO_SITE = https://files.pythonhosted.org/packages/ab/42/b4f04721c5c5bfc196ce156b3c768998ef8c0ae3654ed29ea5020c749a6b
PYTHON_PYAUDIO_SETUP_TYPE = distutils
PYTHON_PYAUDIO_LICENSE = Python-2.0
PYTHON_PYAUDIO_LICENSE_FILES = LICENSE
PYTHON_PYAUDIO_DEPENDENCIES = portaudio

$(eval $(python-package))
