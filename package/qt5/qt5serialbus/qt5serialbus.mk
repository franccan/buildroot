################################################################################
#
# qt5serialbus
#
################################################################################

QT5SERIALBUS_VERSION = $(QT5_VERSION)
QT5SERIALBUS_SITE = $(QT5_SITE)
QT5SERIALBUS_SOURCE = qtserialbus-$(QT5_SOURCE_TARBALL_PREFIX)-$(QT5SERIALBUS_VERSION).tar.xz
QT5SERIALBUS_DEPENDENCIES = qt5base qt5serialport
QT5SERIALBUS_INSTALL_STAGING = YES

QT5SERIALBUS_LICENSE = GPL-2.0 or GPL-3.0 or LGPL-3.0, GFDL-1.3 (docs)
QT5SERIALBUS_LICENSE_FILES = LICENSE.GPLv2 LICENSE.GPLv3 LICENSE.LGPLv3 LICENSE.FDL

define QT5SERIALBUS_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/bin/qmake)
endef

define QT5SERIALBUS_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
	$(call QT5_FIXUP_MAKEFILES,$(@D))
endef

define QT5SERIALBUS_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) INSTALL_ROOT=$(STAGING_DIR) install
	$(QT5_LA_PRL_FILES_FIXUP)
endef

define QT5SERIALBUS_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) INSTALL_ROOT=$(TARGET_DIR) install
endef

$(eval $(generic-package))
