################################################################################
#
# qt5charts
#
################################################################################

# Qt5Charts does not follow Qt versionning for 5.6
ifeq ($(BR2_PACKAGE_QT5_VERSION_LATEST),y)
QT5CHARTS_VERSION = $(QT5_VERSION)
else
QT5CHARTS_VERSION = 2.1.3
endif
QT5CHARTS_SITE = $(QT5_SITE)
QT5CHARTS_SOURCE = qtcharts-$(QT5_SOURCE_TARBALL_PREFIX)-$(QT5CHARTS_VERSION).tar.xz
QT5CHARTS_DEPENDENCIES = qt5base
QT5CHARTS_INSTALL_STAGING = YES

QT5CHARTS_LICENSE = GPL-3.0
ifeq ($(BR2_PACKAGE_QT5_VERSION_LATEST),y)
QT5CHARTS_LICENSE_FILES = LICENSE.GPL3
endif

ifeq ($(BR2_PACKAGE_QT5DECLARATIVE),y)
QT5CHARTS_DEPENDENCIES += qt5declarative
endif

define QT5CHARTS_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/bin/qmake)
endef

define QT5CHARTS_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
	$(call QT5_FIXUP_MAKEFILES,$(@D))
endef

define QT5CHARTS_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) INSTALL_ROOT=$(STAGING_DIR) install
	$(QT5_LA_PRL_FILES_FIXUP)
endef

define QT5CHARTS_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) INSTALL_ROOT=$(TARGET_DIR) install
endef

$(eval $(generic-package))
