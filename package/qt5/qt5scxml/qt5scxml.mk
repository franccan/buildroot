################################################################################
#
# qt5scxml
#
################################################################################

QT5SCXML_VERSION = $(QT5_VERSION)
QT5SCXML_SITE = $(QT5_SITE)
QT5SCXML_SOURCE = qtscxml-$(QT5_SOURCE_TARBALL_PREFIX)-$(QT5SCXML_VERSION).tar.xz
QT5SCXML_DEPENDENCIES = qt5base qt5declarative
QT5SCXML_INSTALL_STAGING = YES

QT5SCXML_LICENSE = GPL-2.0+ or LGPL-3.0, GPL-3.0 with exception(tools), GFDL-1.3 (docs)
QT5SCXML_LICENSE_FILES = LICENSE.GPL3-EXCEPT LICENSE.LGPL3 LICENSE.FDL
ifeq ($(BR2_PACKAGE_QT5BASE_EXAMPLES),y)
QT5SCXML_LICENSE := $(QT5SCXML_LICENSE), BSD-3-Clause (examples)
endif

define QT5SCXML_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/bin/qmake)
endef

define QT5SCXML_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
	$(call QT5_FIXUP_MAKEFILES,$(@D))
endef

define QT5SCXML_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) INSTALL_ROOT=$(STAGING_DIR) install
	$(QT5_LA_PRL_FILES_FIXUP)
endef

define QT5SCXML_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) INSTALL_ROOT=$(TARGET_DIR) install
endef

$(eval $(generic-package))
