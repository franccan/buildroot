################################################################################
#
# libffi
#
################################################################################

ifeq ($(BR2_k1),y)
LIBFFI_VERSION = eacb2cfddcab2a758b20b8b4da84af2166c3c2f9
LIBFFI_SITE = $(call github,kalray,libffi,$(LIBFFI_VERSION))
else
LIBFFI_VERSION = v3.3-rc0
LIBFFI_SITE = $(call github,libffi,libffi,$(LIBFFI_VERSION))
endif
LIBFFI_LICENSE = MIT
LIBFFI_LICENSE_FILES = LICENSE
LIBFFI_INSTALL_STAGING = YES
LIBFFI_AUTORECONF = YES

$(eval $(autotools-package))
$(eval $(host-autotools-package))
