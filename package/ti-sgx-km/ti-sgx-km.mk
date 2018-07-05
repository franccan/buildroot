################################################################################
#
# ti-sgx-km
#
################################################################################

# This corresponds to SDK 04.00.00.00
TI_SGX_KM_VERSION = 0086977380d3320d70a3abc78b95fa0641427073
TI_SGX_KM_SITE = git://git.ti.com/graphics/omap5-sgx-ddk-linux.git
TI_SGX_KM_LICENSE = GPL-2.0
TI_SGX_KM_LICENSE_FILES = eurasia_km/GPL-COPYING

TI_SGX_KM_DEPENDENCIES = linux

TI_SGX_KM_MAKE_OPTS = \
	$(LINUX_MAKE_FLAGS) \
	KERNELDIR=$(LINUX_DIR) \
	PVR_NULLDRM=1

TI_SGX_KM_PLATFORM_NAME = omap

ifeq ($(BR2_PACKAGE_TI_SGX_KM_AM335X),y)
TI_SGX_KM_MAKE_ENV += TARGET_PRODUCT=ti335x
else ifeq ($(BR2_PACKAGE_TI_KM_SGX_AM437X),y)
TI_SGX_KM_MAKE_ENV += TARGET_PRODUCT=ti437x
endif

TI_SGX_KM_SUBDIR = eurasia_km/eurasiacon/build/linux2/$(TI_SGX_KM_PLATFORM_NAME)_linux

define TI_SGX_KM_BUILD_CMDS
	$(TI_SGX_KM_MAKE_ENV) $(TARGET_MAKE_ENV) $(MAKE) $(TI_SGX_KM_MAKE_OPTS) \
		-C $(@D)/$(TI_SGX_KM_SUBDIR)
endef

define TI_SGX_KM_INSTALL_TARGET_CMDS
	$(TI_SGX_KM_MAKE_ENV) $(TARGET_MAKE_ENV) $(MAKE) $(TI_SGX_KM_MAKE_OPTS) \
		DISCIMAGE=$(TARGET_DIR) \
		kbuild_install -C $(@D)/$(TI_SGX_KM_SUBDIR)
endef

$(eval $(generic-package))
