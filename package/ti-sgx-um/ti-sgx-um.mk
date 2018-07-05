################################################################################
#
# ti-sgx-um
#
################################################################################

# This correpsonds to SDK 04.00.00.00
TI_SGX_UM_VERSION = 358fe42d34a7570896e5d1639869da564ddd0484
TI_SGX_UM_SITE = git://git.ti.com/graphics/omap5-sgx-ddk-um-linux.git
TI_SGX_UM_LICENSE = TI TSPA License
TI_SGX_UM_LICENSE_FILES = TI-Linux-Graphics-DDK-UM-Manifest.doc
TI_SGX_UM_INSTALL_STAGING = YES

# ti-sgx-um is a egl/gles provider only if libdrm is installed
TI_SGX_UM_DEPENDENCIES = libdrm
# ti-sgx-libgbm must be built before QT to find EGL
TI_SGX_UM_DEPENDENCIES += ti-sgx-libgbm

# NOTE: TI_SGX_UM is intentionally using TI_SGX_KM variables
ifeq ($(BR2_PACKAGE_TI_SGX_KM_AM335X),y)
TI_SGX_UM_MAKE_ENV += TARGET_PRODUCT=ti335x
else ifeq ($(BR2_PACKAGE_TI_SGX_KM_AM437X),y)
TI_SGX_UM_MAKE_ENV += TARGET_PRODUCT=ti437x
else # BR2_PACKAGE_TI_SGX_KM_AM57X
TI_SGX_UM_MAKE_ENV += TARGET_PRODUCT=jacinto6evm
endif

define TI_SGX_UM_INSTALL_STAGING_CMDS
	$(TI_SGX_UM_MAKE_ENV) $(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DISCIMAGE=$(STAGING_DIR) install
endef

define TI_SGX_UM_INSTALL_TARGET_CMDS
	$(TI_SGX_UM_MAKE_ENV) $(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DISCIMAGE=$(TARGET_DIR) install
endef

# libs use the following file for configuration
define TI_SGX_UM_INSTALL_CONF
	$(INSTALL) -D -m 0644 package/ti-sgx-um/powervr.ini \
		$(TARGET_DIR)/etc/powervr.ini
endef

# Many binaries depend on libGLESv2.so.1, but libGLESv2.so.2 is installed
define TI_SGX_UM_INSTALL_FIX_MESA_STYLE_SYMLINK
	cp -dpf $(TARGET_DIR)/usr/lib/libGLESv2.so.2 $(TARGET_DIR)/usr/lib/libGLESv2.so.1
endef

TI_SGX_UM_POST_INSTALL_TARGET_HOOKS += TI_SGX_UM_INSTALL_CONF TI_SGX_UM_INSTALL_FIX_MESA_STYLE_SYMLINK

# sysV file has the wrong name. Copy it from staging and delete the installed one
define TI_SGX_UM_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(STAGING_DIR)/etc/init.d/rc.pvr \
		$(TARGET_DIR)/etc/init.d/S80ti-sgx
	$(RM) $(TARGET_DIR)/etc/init.d/rc.pvr
endef

$(eval $(generic-package))
