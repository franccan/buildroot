################################################################################
#
# qt5enginio
#
################################################################################

# Qt5Enginio does not follow Qt versionning
# see https://bugreports.qt.io/browse/QTBUG-50111
QT5ENGINIO_VERSION = 1.6.3
QT5ENGINIO_SITE = https://download.qt.io/official_releases/qt/5.6/5.6.3/submodules
QT5ENGINIO_SOURCE = qtenginio-opensource-src-$(QT5ENGINIO_VERSION).tar.xz
QT5ENGINIO_DEPENDENCIES = openssl qt5base
QT5ENGINIO_INSTALL_STAGING = YES

QT5ENGINIO_LICENSE = GPL-3.0 or LGPL-2.1 with exception or LGPL-3.0, GFDL-1.3 (docs)
QT5ENGINIO_LICENSE_FILES = LICENSE.GPLv3 LICENSE.LGPLv21 LGPL_EXCEPTION.txt LICENSE.LGPLv3 LICENSE.FDL
ifeq ($(BR2_PACKAGE_QT5BASE_EXAMPLES),y)
QT5ENGINIO_LICENSE := $(QT5ENGINIO_LICENSE), BSD-3-Clause (examples)
endif

ifeq ($(BR2_PACKAGE_QT5DECLARATIVE),y)
QT5ENGINIO_DEPENDENCIES += qt5declarative
endif

define QT5ENGINIO_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/bin/qmake)
endef

define QT5ENGINIO_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
	$(call QT5_FIXUP_MAKEFILES,$(@D))
endef

define QT5ENGINIO_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) INSTALL_ROOT=$(STAGING_DIR) install
	$(QT5_LA_PRL_FILES_FIXUP)
endef

define QT5ENGINIO_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) INSTALL_ROOT=$(TARGET_DIR) install
endef

$(eval $(generic-package))
