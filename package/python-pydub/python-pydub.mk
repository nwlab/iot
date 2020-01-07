################################################################################
#
# python-pydub
#
################################################################################

PYTHON_PYDUB_VERSION = 0.23.1
PYTHON_PYDUB_SOURCE = pydub-$(PYTHON_PYDUB_VERSION).tar.gz
PYTHON_PYDUB_SITE = https://files.pythonhosted.org/packages/aa/20/e6ec4fe31d56d2ad4d6adbbd3afd03bb9b960926c42dfb1fdf42dc826787
PYTHON_PYDUBD_LICENSE = MIT
PYTHON_PYDUB_LICENSE_FILES = LICENSE
PYTHON_PYDUB_SETUP_TYPE = setuptools
PYTHON_PYDUB_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
