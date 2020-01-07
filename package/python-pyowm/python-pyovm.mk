################################################################################
#
# python-pyovm
#
################################################################################

PYTHON_PYOWM_VERSION = 2.10.0
PYTHON_PYOWM_SOURCE = pyowm-$(PYTHON_PYOWM_VERSION).tar.gz
PYTHON_PYOWM_SITE = https://files.pythonhosted.org/packages/a9/7b/c527a8acbadb90a323724d719cd137c906436c341071a963372583bbe3b0
PYTHON_PYOWM_LICENSE = MIT
PYTHON_PYOWM_LICENSE_FILES = LICENSE
PYTHON_PYOWM_SETUP_TYPE = setuptools
PYTHON_PYOWM_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
