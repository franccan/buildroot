################################################################################
#
# qt5
#
################################################################################

ifeq ($(BR2_PACKAGE_QT5_VERSION_LATEST),y)
QT5_VERSION_MAJOR = 5.11
QT5_VERSION = $(QT5_VERSION_MAJOR).2
QT5_SOURCE_TARBALL_PREFIX = everywhere-src
else
QT5_VERSION_MAJOR = 5.6
QT5_VERSION = $(QT5_VERSION_MAJOR).3
QT5_SOURCE_TARBALL_PREFIX = opensource-src
endif
QT5_SITE = https://download.qt.io/official_releases/qt/$(QT5_VERSION_MAJOR)/$(QT5_VERSION)/submodules

include $(sort $(wildcard package/qt5/*/*.mk))

define QT5_LA_PRL_FILES_FIXUP
	for i in $$(find $(STAGING_DIR)/usr/lib* -name "libQt5*.la"); do \
		$(SED)  "s:$(BASE_DIR):@BASE_DIR@:g" \
			-e "s:$(STAGING_DIR):@STAGING_DIR@:g" \
			-e "s:\(['= ]\)/usr:\\1@STAGING_DIR@/usr:g" \
			-e "s:@STAGING_DIR@:$(STAGING_DIR):g" \
			-e "s:@BASE_DIR@:$(BASE_DIR):g" \
			$$i ; \
		$(SED) "/^dependency_libs=/s%-L/usr/lib %%g" $$i ; \
	done
	for i in $$(find $(STAGING_DIR)/usr/lib* -name "libQt5*.prl"); do \
		$(SED) "s%-L/usr/lib%%" $$i; \
	done
endef

# Fixup the makefiles generated by qmake so that INSTALL_ROOT can be
# used like DESTDIR.
#
# $(INSTALL_ROOT)/$(STAGING_DIR) is replaced by just $(INSTALL_ROOT),
# so that we can do make INSTALL_ROOT=STAGING_DIR/TARGET_DIR installed
#
# $(INSTALL_ROOT)/$(HOST_DIR) is replaced by just $(HOST_DIR), so that
# regardless of the INSTALL_ROOT value, host programs/data are
# installed in $(HOST_DIR)
define QT5_FIXUP_MAKEFILES
	find $(1) -name 'Makefile' -o -name 'Makefile.app' | \
		xargs $(SED) 's,$$(INSTALL_ROOT)$(STAGING_DIR),$$(INSTALL_ROOT),g'
	find $(1) -name 'Makefile' -o -name 'Makefile.app' | \
		xargs $(SED) 's,$$(INSTALL_ROOT)$(HOST_DIR),$(HOST_DIR),g'
endef

# Remove all empty folders in $(1)/$(2), up to $(1)
define QT5_RECURSIVE_REMOVE_DIRS
	tmp=`dirname $(1)/$(2)` ; \
	while test "$${tmp}" != "$(1)" ; do \
		rmdir $${tmp} ; \
		tmp=`dirname $${tmp}` ; \
	done
endef


# Variable for other Qt applications to use
QT5_QMAKE = $(HOST_DIR)/bin/qmake -spec devices/linux-buildroot-g++
