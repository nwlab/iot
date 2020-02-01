################################################################################
#
# python-pocketsphinx
#
################################################################################

PYTHON_POCKETSPHINX_VERSION = 769492da47e41b71e3dd57a6b033fbba79e57032
PYTHON_POCKETSPHINX_SITE = $(call github,bambocher,pocketsphinx-python,$(PYTHON_POCKETSPHINX_VERSION))
PYTHON_POCKETSPHINX_SETUP_TYPE = setuptools
PYTHON_POCKETSPHINX_LICENSE = GPL-2.0+
PYTHON_POCKETSPHINX_LICENSE_FILES = COPYING
PYTHON_POCKETSPHINX_DEPENDENCIES = host-python-setuptools-scm pocketsphinx sphinxbase alsa-lib

define PYTHON_POCKETSPHINX_UPDATE_DEPS
	rm -rf $(@D)/deps/pocketsphinx $(@D)/deps/sphinxbase
    ln -s $(POCKETSPHINX_SRCDIR) $(@D)/deps/pocketsphinx
    ln -s $(SPHINXBASE_SRCDIR) $(@D)/deps/sphinxbase
endef

PYTHON_POCKETSPHINX_POST_EXTRACT_HOOKS = PYTHON_POCKETSPHINX_UPDATE_DEPS

$(eval $(python-package))
