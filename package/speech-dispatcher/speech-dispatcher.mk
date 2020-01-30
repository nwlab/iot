################################################################################
#
# speech-dispatcher
#
################################################################################

SPEECH_DISPATCHER_VERSION = a6660e9b074aa528678dd68f6903f774f3c8bb6b
SPEECH_DISPATCHER_SITE = $(call github,brailcom,speechd,$(SPEECH_DISPATCHER_VERSION))

SPEECH_DISPATCHER_LICENSE = MIT
SPEECH_DISPATCHER_LICENSE_FILES = COPYING
SPEECH_DISPATCHER_DEPENDENCIES = libsndfile libdotconf

SPEECH_DISPATCHER_AUTORECONF = YES

$(eval $(autotools-package))
