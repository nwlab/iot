################################################################################
#
# python-rhvoice
#
################################################################################

PYTHON_RHVOICE_VERSION = 0.5.1.5
PYTHON_RHVOICE_SOURCE = RHVoice-$(PYTHON_RHVOICE_VERSION).tar.gz
PYTHON_RHVOICE_SITE = https://files.pythonhosted.org/packages/aa/20/e6ec4fe31d56d2ad4d6adbbd3afd03bb9b960926c42dfb1fdf42dc826787
PYTHON_RHVOICE_LICENSE = MIT
PYTHON_RHVOICE_LICENSE_FILES = LICENSE
PYTHON_RHVOICE_SETUP_TYPE = setuptools
PYTHON_RHVOICE_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
