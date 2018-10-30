################################################################################
#
# ti-sgx-libgbm
#
################################################################################

# This is the current "next" branch, which corresponds to SDK 04.00.00.00
TI_SGX_LIBGBM_VERSION = 43cc786d0e5b8274fa93048c7f3bb8d6b62522db
TI_SGX_LIBGBM_SITE = git://git.ti.com/glsdk/libgbm.git
TI_SGX_LIBGBM_INSTALL_STAGING = YES
TI_SGX_LIBGBM_AUTORECONF = YES
TI_SGX_LIBGBM_LICENSE = MIT
TI_SGX_LIBGBM_LICENSE_FILES = debian/copyright
TI_SGX_LIBGBM_PROVIDES = libgbm
TI_SGX_LIBGBM_DEPENDENCIES = libdrm udev

$(eval $(autotools-package))
